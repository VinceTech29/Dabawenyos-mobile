enum AnnouncementCategory {
  general,
  traffic,
  weather,
  publicService,
  utilities, // water & power
  health,
  government;

  String get label {
    switch (this) {
      case AnnouncementCategory.general:
        return 'General';
      case AnnouncementCategory.traffic:
        return 'Traffic Advisory';
      case AnnouncementCategory.weather:
        return 'Weather & DRRMO';
      case AnnouncementCategory.publicService:
        return 'Public Service';
      case AnnouncementCategory.utilities:
        return 'Water & Power';
      case AnnouncementCategory.health:
        return 'Health Advisory';
      case AnnouncementCategory.government:
        return 'Programs';
    }
  }
}

class Announcement {
  final String id;
  final String title;
  final String summary;
  final String content;
  final AnnouncementCategory category;
  final String source;
  final DateTime publishedAt;
  final bool isUrgent;
  final String? imageUrl;
  final bool isBookmarked;

  const Announcement({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.category,
    required this.source,
    required this.publishedAt,
    this.isUrgent = false,
    this.imageUrl,
    this.isBookmarked = false,
  });

  Announcement copyWith({
    String? id,
    String? title,
    String? summary,
    String? content,
    AnnouncementCategory? category,
    String? source,
    DateTime? publishedAt,
    bool? isUrgent,
    String? imageUrl,
    bool? isBookmarked,
  }) {
    return Announcement(
      id: id ?? this.id,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      content: content ?? this.content,
      category: category ?? this.category,
      source: source ?? this.source,
      publishedAt: publishedAt ?? this.publishedAt,
      isUrgent: isUrgent ?? this.isUrgent,
      imageUrl: imageUrl ?? this.imageUrl,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'summary': summary,
    'content': content,
    'category': category.name,
    'source': source,
    'publishedAt': publishedAt.toIso8601String(),
    'isUrgent': isUrgent,
    'imageUrl': imageUrl,
    'isBookmarked': isBookmarked,
  };

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
    id: json['id'] as String,
    title: json['title'] as String,
    summary: json['summary'] as String,
    content: json['content'] as String,
    category: AnnouncementCategory.values.byName(json['category'] as String),
    source: json['source'] as String,
    publishedAt: DateTime.parse(json['publishedAt'] as String),
    isUrgent: json['isUrgent'] as bool? ?? false,
    imageUrl: json['imageUrl'] as String?,
    isBookmarked: json['isBookmarked'] as bool? ?? false,
  );
}
