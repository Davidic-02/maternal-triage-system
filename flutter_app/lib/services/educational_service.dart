import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maternal_triage/models/education_content.dart';
import 'package:maternal_triage/services/logging_helper.dart';

final _youtubeApiKey = dotenv.env['YOUTUBE_API_KEY'];
const _cacheKey = 'education_cache_v1';

class EducationService {
  static final EducationService _instance = EducationService._();
  factory EducationService() => _instance;
  EducationService._();

  // ── Public entry point ────────────────────────────────────────

  Future<EducationCache> getContent({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cached = await _loadCache();
      if (cached != null && !cached.isStale) {
        logInfo('EducationService: serving from cache');
        return cached;
      }
    }
    logInfo('EducationService: fetching fresh content');
    return _fetchAndCache();
  }

  // ── Fetch ─────────────────────────────────────────────────────

  Future<EducationCache> _fetchAndCache() async {
    final results = await Future.wait([
      _fetchYouTubeVideos(),
      _fetchMedlinePlusGuides(),
    ]);

    final cache = EducationCache(
      videos: results[0] as List<EducationVideo>,
      guides: results[1] as List<EducationGuide>,
      fetchedAt: DateTime.now(),
    );

    await _saveCache(cache);
    return cache;
  }

  // ── YouTube ───────────────────────────────────────────────────

  static const _youtubeQueries = [
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
    if (_youtubeApiKey == 'YOUR_YOUTUBE_API_KEY_HERE') {
      logInfo('EducationService: no YouTube key — using fallbacks');
      return _fallbackVideos();
    }

    final videos = <EducationVideo>[];

    for (final q in _youtubeQueries) {
      try {
        final uri = Uri.https('www.googleapis.com', '/youtube/v3/search', {
          'part': 'snippet',
          'q': q.query,
          'type': 'video',
          'maxResults': q.featured ? '1' : '2',
          'relevanceLanguage': 'en',
          'safeSearch': 'strict',
          'key': _youtubeApiKey,
        });

        final response = await http
            .get(uri)
            .timeout(const Duration(seconds: 10));

        if (response.statusCode != 200) {
          logInfo('YouTube [${response.statusCode}] failed for: ${q.query}');
          continue;
        }

        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final items = json['items'] as List? ?? [];

        for (int i = 0; i < items.length; i++) {
          videos.add(
            EducationVideo.fromYouTubeJson(
              items[i] as Map<String, dynamic>,
              trimesterTag: q.tag,
              isFeatured: q.featured && i == 0,
            ),
          );
        }
      } catch (e) {
        logInfo('YouTube query error: $e');
      }
    }

    return videos.isEmpty ? _fallbackVideos() : videos;
  }

  // ── MedlinePlus ───────────────────────────────────────────────

  static const _medlinePlusQueries = [
    ('Nutrition during pregnancy iron protein', 'nutrition'),
    ('Preeclampsia warning signs high blood pressure pregnancy', 'warning'),
    ('Birth plan labor delivery preparation', 'birth'),
    ('Postpartum care recovery after delivery', 'general'),
  ];

  Future<List<EducationGuide>> _fetchMedlinePlusGuides() async {
    final guides = <EducationGuide>[];

    for (final (query, category) in _medlinePlusQueries) {
      try {
        final uri = Uri.https('wsearch.nlm.nih.gov', '/api/query', {
          'db': 'healthTopics',
          'term': query,
          'rettype': 'brief',
          'retmax': '1',
        });

        final response = await http
            .get(uri, headers: {'Accept': 'application/json'})
            .timeout(const Duration(seconds: 10));

        if (response.statusCode != 200) continue;

        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final list = json['list'] as Map<String, dynamic>?;
        final items = list?['document'] as List? ?? [];

        for (final item in items) {
          final map = item as Map<String, dynamic>;
          guides.add(
            EducationGuide(
              id: map['@ui'] as String? ?? query,
              title: map['title']?['#text'] as String? ?? query,
              subtitle: _subtitleFor(category),
              category: category,
              url: map['@url'] as String? ?? '',
              summary: _extractSummary(map),
            ),
          );
        }
      } catch (e) {
        logInfo('MedlinePlus error for "$query": $e');
      }
    }

    return _mergeWithFallbacks(guides);
  }

  String _subtitleFor(String category) {
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
                  )
                  as Map?)?['#text']
              as String? ??
          '';
    }
    return '';
  }

  // ── Fallbacks ─────────────────────────────────────────────────

  List<EducationVideo> _fallbackVideos() => [
    const EducationVideo(
      id: 'fb_3rd_1',
      title: 'Managing High Blood Pressure in Pregnancy',
      subtitle: 'World Health Organization',
      thumbnailUrl: 'https://img.youtube.com/vi/vBRqFTZcmtY/hqdefault.jpg',
      youtubeVideoId: 'vBRqFTZcmtY',
      trimesterTag: 'third',
      isFeatured: true,
      duration: '4 mins',
    ),
    const EducationVideo(
      id: 'fb_3rd_2',
      title: 'The Delivery Day Checklist',
      subtitle: 'Maternal Health Awareness',
      thumbnailUrl: 'https://img.youtube.com/vi/3OEYTauqEgU/hqdefault.jpg',
      youtubeVideoId: '3OEYTauqEgU',
      trimesterTag: 'third',
      isFeatured: false,
      duration: '3 mins',
    ),
    const EducationVideo(
      id: 'fb_1st_1',
      title: 'First Trimester: What to Expect',
      subtitle: 'WHO Maternal Health',
      thumbnailUrl: 'https://img.youtube.com/vi/AP9a01MjCHo/hqdefault.jpg',
      youtubeVideoId: 'AP9a01MjCHo',
      trimesterTag: 'first',
      isFeatured: true,
      duration: '5 mins',
    ),
    const EducationVideo(
      id: 'fb_2nd_1',
      title: 'Nutrition and Movement in Pregnancy',
      subtitle: 'UNICEF',
      thumbnailUrl: 'https://img.youtube.com/vi/3OEYTauqEgU/hqdefault.jpg',
      youtubeVideoId: '3OEYTauqEgU',
      trimesterTag: 'second',
      isFeatured: true,
      duration: '6 mins',
    ),
    const EducationVideo(
      id: 'fb_post_1',
      title: 'Postpartum Recovery',
      subtitle: 'WHO',
      thumbnailUrl: 'https://img.youtube.com/vi/AP9a01MjCHo/hqdefault.jpg',
      youtubeVideoId: 'AP9a01MjCHo',
      trimesterTag: 'postpartum',
      isFeatured: true,
      duration: '7 mins',
    ),
  ];

  List<EducationGuide> _mergeWithFallbacks(List<EducationGuide> fetched) {
    const fallbacks = [
      EducationGuide(
        id: 'guide_nutrition',
        title: 'Nutrition Guide',
        subtitle: 'Iron and Protein needs',
        category: 'nutrition',
        url: 'https://medlineplus.gov/nutritionforpregnancy.html',
        summary: 'Key nutrients during pregnancy including iron and protein.',
      ),
      EducationGuide(
        id: 'guide_warning',
        title: 'Warning Signs',
        subtitle: 'Emergency Indicators',
        category: 'warning',
        url: 'https://medlineplus.gov/ency/patientinstructions/000580.htm',
        summary: 'Warning signs that require immediate medical attention.',
      ),
      EducationGuide(
        id: 'guide_birth',
        title: 'Birth Plan',
        subtitle: 'Prepare for delivery',
        category: 'birth',
        url: 'https://medlineplus.gov/ency/patientinstructions/000579.htm',
        summary: 'Prepare everything you need for a safe delivery.',
      ),
    ];

    final fetchedCategories = fetched.map((g) => g.category).toSet();
    final merged = [...fetched];
    for (final fb in fallbacks) {
      if (!fetchedCategories.contains(fb.category)) {
        merged.add(fb);
      }
    }
    return merged;
  }

  // ── SharedPreferences cache ───────────────────────────────────

  Future<EducationCache?> _loadCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_cacheKey);
      if (raw == null) return null;
      return _deserializeCache(jsonDecode(raw) as Map<String, dynamic>);
    } catch (e) {
      logInfo('EducationService: cache read failed — $e');
      return null;
    }
  }

  Future<void> _saveCache(EducationCache cache) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_cacheKey, jsonEncode(_serializeCache(cache)));
    } catch (e) {
      logInfo('EducationService: cache write failed — $e');
    }
  }

  // ── Serialization ─────────────────────────────────────────────

  Map<String, dynamic> _serializeCache(EducationCache c) => {
    'videos': c.videos.map(_serializeVideo).toList(),
    'guides': c.guides.map(_serializeGuide).toList(),
    'fetchedAt': c.fetchedAt.toIso8601String(),
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
