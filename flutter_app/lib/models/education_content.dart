import 'package:hive/hive.dart';

part 'education_content.g.dart';

// ── Video Model ───────────────────────────────────────────────

@HiveType(typeId: 10)
class EducationVideo extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String subtitle;

  @HiveField(3)
  final String thumbnailUrl;

  @HiveField(4)
  final String youtubeVideoId;

  @HiveField(5)
  final String trimesterTag; // 'first' | 'second' | 'third' | 'postpartum'

  @HiveField(6)
  final bool isFeatured;

  @HiveField(7)
  final String duration;

  const EducationVideo({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.thumbnailUrl,
    required this.youtubeVideoId,
    required this.trimesterTag,
    required this.isFeatured,
    required this.duration,
  });

  factory EducationVideo.fromYouTubeJson(
    Map<String, dynamic> json, {
    required String trimesterTag,
    required bool isFeatured,
  }) {
    final snippet = json['snippet'] as Map<String, dynamic>;
    final id = (json['id'] is Map)
        ? (json['id'] as Map<String, dynamic>)['videoId'] as String
        : json['id'] as String;

    final thumbs = snippet['thumbnails'] as Map<String, dynamic>;
    final thumbUrl =
        (thumbs['high'] ?? thumbs['medium'] ?? thumbs['default'])['url']
            as String;

    // Parse ISO 8601 duration from contentDetails if present
    final duration = _parseDuration(
      (json['contentDetails'] as Map<String, dynamic>?)?['duration'] as String?,
    );

    return EducationVideo(
      id: id,
      title: snippet['title'] as String,
      subtitle: snippet['channelTitle'] as String? ?? '',
      thumbnailUrl: thumbUrl,
      youtubeVideoId: id,
      trimesterTag: trimesterTag,
      isFeatured: isFeatured,
      duration: duration,
    );
  }

  static String _parseDuration(String? iso) {
    if (iso == null) return '';
    final match = RegExp(
      r'PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?',
    ).firstMatch(iso);
    if (match == null) return '';
    final h = int.tryParse(match.group(1) ?? '') ?? 0;
    final m = int.tryParse(match.group(2) ?? '') ?? 0;
    final s = int.tryParse(match.group(3) ?? '') ?? 0;
    if (h > 0) return '${h}h ${m}m';
    if (m > 0) return '${m}m ${s > 0 ? '${s}s' : ''}';
    return '${s}s';
  }
}

// ── Guide Model ───────────────────────────────────────────────

@HiveType(typeId: 11)
class EducationGuide extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String subtitle;

  @HiveField(3)
  final String category; // 'nutrition' | 'warning' | 'birth' | 'general'

  @HiveField(4)
  final String url; // Deep link to full article

  @HiveField(5)
  final String summary;

  const EducationGuide({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.url,
    required this.summary,
  });

  factory EducationGuide.fromMedlinePlusJson(Map<String, dynamic> json) {
    final result = json['result'] as Map<String, dynamic>? ?? json;
    return EducationGuide(
      id: result['id']?.toString() ?? UniqueKey().toString(),
      title: result['title'] as String? ?? '',
      subtitle: result['organizations']?.toString() ?? 'MedlinePlus',
      category: _inferCategory(result['title'] as String? ?? ''),
      url: result['url'] as String? ?? '',
      summary:
          result['snippet'] as String? ??
          result['fullSummary'] as String? ??
          '',
    );
  }

  static String _inferCategory(String title) {
    final t = title.toLowerCase();
    if (t.contains('nutrition') || t.contains('iron') || t.contains('diet')) {
      return 'nutrition';
    }
    if (t.contains('warning') ||
        t.contains('danger') ||
        t.contains('emergency') ||
        t.contains('preeclampsia')) {
      return 'warning';
    }
    if (t.contains('birth') || t.contains('labor') || t.contains('delivery')) {
      return 'birth';
    }
    return 'general';
  }
}

// ── Cache Envelope ────────────────────────────────────────────

@HiveType(typeId: 12)
class EducationCache extends HiveObject {
  @HiveField(0)
  final List<EducationVideo> videos;

  @HiveField(1)
  final List<EducationGuide> guides;

  @HiveField(2)
  final DateTime fetchedAt;

  const EducationCache({
    required this.videos,
    required this.guides,
    required this.fetchedAt,
  });

  bool get isStale =>
      DateTime.now().difference(fetchedAt) > const Duration(hours: 24);
}
