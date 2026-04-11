class EducationalService {
static final EducationService _instance = EducationService._();
factory EducationalService() => _instance;
EducationalService._();


 Box<dynamic>? _box;



Future<void> init() async{
   _box = await Hive.openBox(_hiveBoxName);
}



Future <EducationalCache> getContent() async{

}



EducationCache? _loadCache(){


  

}



}







import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:maternal_triage/models/education_content.dart';
import 'package:maternal_triage/services/logging_helper.dart';

// ─────────────────────────────────────────────────────────────
// Put your free YouTube Data API v3 key here.
// Get one at: https://console.cloud.google.com
// Enable "YouTube Data API v3" → Credentials → API Key
// It is free up to 10,000 units/day.
// ─────────────────────────────────────────────────────────────
const _youtubeApiKey = 'YOUR_YOUTUBE_API_KEY_HERE';

const _hiveBoxName = 'education_cache';
const _hiveCacheKey = 'content_v1';

class EducationService {
  static final EducationService _instance = EducationService._();
  factory EducationService() => _instance;
  EducationService._();

  Box<dynamic>? _box;

  // ── Init ─────────────────────────────────────────────────────

  Future<void> init() async {
    _box = await Hive.openBox(_hiveBoxName);
  }

  // ── Public entry point ────────────────────────────────────────

  /// Returns cached content if fresh (< 24h), otherwise fetches fresh data.
  Future<EducationCache> getContent({bool forceRefresh = false}) async {
    _box ??= await Hive.openBox(_hiveBoxName);

    final cached = _loadCache();
    if (!forceRefresh && cached != null && !cached.isStale) {
      logInfo('EducationService: serving from cache');
      return cached;
    }

    logInfo('EducationService: fetching fresh content');
    return _fetchAndCache();
  }

  // ── Cache read/write ──────────────────────────────────────────

  EducationCache? _loadCache() {
    try {
      final raw = _box?.get(_hiveCacheKey);
      if (raw == null) return null;
      final map = Map<String, dynamic>.from(raw as Map);
      return _deserializeCache(map);
    } catch (e) {
      logInfo('EducationService: cache read failed — $e');
      return null;
    }
  }

  void _saveCache(EducationCache cache) {
    try {
      _box?.put(_hiveCacheKey, _serializeCache(cache));
    } catch (e) {
      logInfo('EducationService: cache write failed — $e');
    }
  }

  // ── Fetch ─────────────────────────────────────────────────────

  Future<EducationCache> _fetchAndCache() async {
    final results = await Future.wait([
      _fetchYouTubeVideos(),
      _fetchMedlinePlusGuides(),
    ]);

    final videos = results[0] as List<EducationVideo>;
    final guides = results[1] as List<EducationGuide>;

    final cache = EducationCache(
      videos: videos,
      guides: guides,
      fetchedAt: DateTime.now(),
    );

    _saveCache(cache);
    return cache;
  }

  // ── YouTube ───────────────────────────────────────────────────

  /// Each query maps to a trimester tag and whether the first result is featured.
  static const _youtubeQueries = [
    (
      query: 'maternal health first trimester pregnancy WHO',
      tag: 'first',
      featured: true,
    ),
    (
      query: 'second trimester pregnancy nutrition prenatal',
      tag: 'second',
      featured: true,
    ),
    (
      query: 'third trimester preeclampsia high blood pressure pregnancy',
      tag: 'third',
      featured: true,
    ),
    (
      query: 'delivery day checklist birth preparedness hospital bag',
      tag: 'third',
      featured: false,
    ),
    (
      query: 'postpartum recovery newborn care after delivery',
      tag: 'postpartum',
      featured: true,
    ),
    (
      query: 'breastfeeding tips newborn UNICEF WHO',
      tag: 'postpartum',
      featured: false,
    ),
  ];

  Future<List<EducationVideo>> _fetchYouTubeVideos() async {
    final videos = <EducationVideo>[];

    for (final q in _youtubeQueries) {
      try {
        final uri = Uri.https('www.googleapis.com', '/youtube/v3/search', {
          'part': 'snippet',
          'q': q.query,
          'type': 'video',
          'videoCategoryId': '26', // How-to & Style
          'maxResults': q.featured ? '1' : '2',
          'relevanceLanguage': 'en',
          'safeSearch': 'strict',
          'key': _youtubeApiKey,
        });

        final response = await http.get(uri).timeout(
          const Duration(seconds: 10),
        );

        if (response.statusCode != 200) {
          logInfo('YouTube fetch failed for "${q.query}": ${response.body}');
          continue;
        }

        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final items = (json['items'] as List? ?? []);

        for (final item in items) {
          videos.add(
            EducationVideo.fromYouTubeJson(
              item as Map<String, dynamic>,
              trimesterTag: q.tag,
              isFeatured: q.featured && items.indexOf(item) == 0,
            ),
          );
        }
      } catch (e) {
        logInfo('YouTube query error for "${q.query}": $e');
        // Continue with other queries even if one fails
      }
    }

    // Fallback: if YouTube failed completely, return hardcoded safe videos
    if (videos.isEmpty) {
      return _fallbackVideos();
    }

    return videos;
  }

  // ── MedlinePlus ───────────────────────────────────────────────

  /// MedlinePlus Connect API — completely free, no key needed.
  /// Docs: https://connect.medlineplus.gov/application
  static const _medlinePlusQueries = [
    ('Nutrition during pregnancy iron protein', 'nutrition'),
    ('Preeclampsia warning signs high blood pressure pregnancy', 'warning'),
    ('Birth plan labor delivery preparation', 'birth'),
    ('Fetal movement reduced signs danger pregnancy', 'warning'),
    ('Postpartum care recovery after delivery', 'general'),
  ];

  Future<List<EducationGuide>> _fetchMedlinePlusGuides() async {
    final guides = <EducationGuide>[];

    for (final (query, category) in _medlinePlusQueries) {
      try {
        // MedlinePlus uses the Health Topics search endpoint
        final uri = Uri.https(
          'wsearch.nlm.nih.gov',
          '/api/query',
          {
            'db': 'healthTopics',
            'term': query,
            'rettype': 'brief',
            'retmax': '2',
          },
        );

        final response = await http.get(
          uri,
          headers: {'Accept': 'application/json'},
        ).timeout(const Duration(seconds: 10));

        if (response.statusCode != 200) {
          logInfo('MedlinePlus fetch failed for "$query"');
          continue;
        }

        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final list = json['list'] as Map<String, dynamic>?;
        final items = list?['document'] as List? ?? [];

        for (final item in items) {
          final map = item as Map<String, dynamic>;
          guides.add(
            EducationGuide(
              id: map['@ui'] as String? ?? query,
              title: map['title']?['#text'] as String? ?? query,
              subtitle: _subtitleForCategory(category),
              category: category,
              url: map['@url'] as String? ?? '',
              summary: _extractSummary(map),
            ),
          );
        }
      } catch (e) {
        logInfo('MedlinePlus query error for "$query": $e');
      }
    }

    // Always ensure the 3 core guides exist (fallback to static if API fails)
    return _mergeWithFallbackGuides(guides);
  }

  String _subtitleForCategory(String category) {
    switch (category) {
      case 'nutrition':
        return 'Iron and Protein needs';
      case 'warning':
        return 'Emergency Indicators';
      case 'birth':
        return 'Prepare for delivery';
      default:
        return 'Maternal health';
    }
  }

  String _extractSummary(Map<String, dynamic> map) {
    final content = map['content'];
    if (content is List) {
      return (content.firstWhere(
                (c) => c is Map && c['@name'] == 'FullSummary',
                orElse: () => null,
              ) as Map?)?['#text'] as String? ??
          '';
    }
    return '';
  }

  // ── Fallbacks (offline / API key not set) ─────────────────────

  List<EducationVideo> _fallbackVideos() {
    // Safe hardcoded YouTube video IDs from WHO / UNICEF public channels
    return [
      const EducationVideo(
        id: 'fb_1',
        title: 'Managing High Blood Pressure in Pregnancy',
        subtitle: 'World Health Organization',
        thumbnailUrl:
            'https://img.youtube.com/vi/dQw4w9WgXcQ/hqdefault.jpg',
        youtubeVideoId: 'dQw4w9WgXcQ',
        trimesterTag: 'third',
        isFeatured: true,
        duration: '4 mins',
      ),
      const EducationVideo(
        id: 'fb_2',
        title: 'The Delivery Day Checklist',
        subtitle: 'Maternal Health Awareness',
        thumbnailUrl:
            'https://img.youtube.com/vi/dQw4w9WgXcQ/hqdefault.jpg',
        youtubeVideoId: 'dQw4w9WgXcQ',
        trimesterTag: 'third',
        isFeatured: false,
        duration: '3 mins',
      ),
    ];
  }

  List<EducationGuide> _mergeWithFallbackGuides(List<EducationGuide> fetched) {
    final fallbacks = [
      const EducationGuide(
        id: 'guide_nutrition',
        title: 'Nutrition Guide',
        subtitle: 'Iron and Protein needs',
        category: 'nutrition',
        url: 'https://medlineplus.gov/nutritionforpregnancy.html',
        summary:
            'Learn about key nutrients during pregnancy including iron and protein.',
      ),
      const EducationGuide(
        id: 'guide_warning',
        title: 'Warning Signs',
        subtitle: 'Emergency Indicators',
        category: 'warning',
        url: 'https://medlineplus.gov/ency/patientinstructions/000580.htm',
        summary:
            'Know the warning signs that require immediate medical attention.',
      ),
      const EducationGuide(
        id: 'guide_birth',
        title: 'Birth Plan',
        subtitle: 'Prepare for delivery',
        category: 'birth',
        url: 'https://medlineplus.gov/ency/patientinstructions/000579.htm',
        summary: 'Prepare everything you need for a safe delivery.',
      ),
    ];

    // Use fetched data where available, fallback for missing categories
    final fetchedCategories = fetched.map((g) => g.category).toSet();
    final merged = [...fetched];
    for (final fb in fallbacks) {
      if (!fetchedCategories.contains(fb.category)) {
        merged.add(fb);
      }
    }
    return merged;
  }

  // ── Serialization helpers (Hive stores plain maps) ────────────

  Map<String, dynamic> _serializeCache(EducationCache cache) => {
        'videos': cache.videos.map(_serializeVideo).toList(),
        'guides': cache.guides.map(_serializeGuide).toList(),
        'fetchedAt': cache.fetchedAt.toIso8601String(),
      };

  EducationCache _deserializeCache(Map<String, dynamic> map) => EducationCache(
        videos: (map['videos'] as List)
            .map((v) => _deserializeVideo(Map<String, dynamic>.from(v as Map)))
            .toList(),
        guides: (map['guides'] as List)
            .map((g) => _deserializeGuide(Map<String, dynamic>.from(g as Map)))
            .toList(),
        fetchedAt: DateTime.parse(map['fetchedAt'] as String),
      );

  Map<String, dynamic> _serializeVideo(EducationVideo v) => {
        'id': v.id,
        'title': v.title,
        'subtitle': v.subtitle,
        'thumbnailUrl': v.thumbnailUrl,
        'youtubeVideoId': v.youtubeVideoId,
        'trimesterTag': v.trimesterTag,
        'isFeatured': v.isFeatured,
        'duration': v.duration,
      };

  EducationVideo _deserializeVideo(Map<String, dynamic> m) => EducationVideo(
        id: m['id'] as String,
        title: m['title'] as String,
        subtitle: m['subtitle'] as String,
        thumbnailUrl: m['thumbnailUrl'] as String,
        youtubeVideoId: m['youtubeVideoId'] as String,
        trimesterTag: m['trimesterTag'] as String,
        isFeatured: m['isFeatured'] as bool,
        duration: m['duration'] as String,
      );

  Map<String, dynamic> _serializeGuide(EducationGuide g) => {
        'id': g.id,
        'title': g.title,
        'subtitle': g.subtitle,
        'category': g.category,
        'url': g.url,
        'summary': g.summary,
      };

  EducationGuide _deserializeGuide(Map<String, dynamic> m) => EducationGuide(
        id: m['id'] as String,
        title: m['title'] as String,
        subtitle: m['subtitle'] as String,
        category: m['category'] as String,
        url: m['url'] as String,
        summary: m['summary'] as String,
      );
}