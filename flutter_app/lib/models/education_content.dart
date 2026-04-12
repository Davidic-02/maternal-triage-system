class EducationVideo {
  final String id;
  final String title;
  final String subtitle;
  final String thumbnailUrl;
  final String youtubeVideoId;
  final String trimesterTag; // 'first' | 'second' | 'third' | 'postpartum'
  final bool isFeatured;
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
        ((thumbs['high'] ?? thumbs['medium'] ?? thumbs['default'])
                as Map<String, dynamic>)['url']
            as String;

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
    if (m > 0) return '${m}m${s > 0 ? ' ${s}s' : ''}';
    return '${s}s';
  }
}

class EducationGuide {
  final String id;
  final String title;
  final String subtitle;
  final String category; // 'nutrition' | 'warning' | 'birth' | 'general'
  final String url;
  final String summary;

  const EducationGuide({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.url,
    required this.summary,
  });
}

class EducationCache {
  final List<EducationVideo> videos;
  final List<EducationGuide> guides;
  final DateTime fetchedAt;

  const EducationCache({
    required this.videos,
    required this.guides,
    required this.fetchedAt,
  });

  bool get isStale =>
      DateTime.now().difference(fetchedAt) > const Duration(hours: 24);
}
