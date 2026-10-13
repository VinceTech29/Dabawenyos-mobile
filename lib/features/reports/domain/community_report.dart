enum ReportStatus {
  submitted,
  underReview,
  acknowledged,
  inProgress,
  resolved;

  String get label {
    switch (this) {
      case ReportStatus.submitted:
        return 'Submitted';
      case ReportStatus.underReview:
        return 'Under Review';
      case ReportStatus.acknowledged:
        return 'Acknowledged';
      case ReportStatus.inProgress:
        return 'In Progress';
      case ReportStatus.resolved:
        return 'Resolved';
    }
  }
}

class CommunityReport {
  final String id;
  final String category;
  final String title;
  final String description;
  final String location;
  final String? barangay;
  final double? latitude;
  final double? longitude;
  final String? photoUrl;
  final ReportStatus status;
  final int upvotes;
  final DateTime createdAt;
  final bool hasUpvoted;

  const CommunityReport({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.location,
    this.barangay,
    this.latitude,
    this.longitude,
    this.photoUrl,
    required this.status,
    required this.upvotes,
    required this.createdAt,
    this.hasUpvoted = false,
  });

  CommunityReport copyWith({
    String? id,
    String? category,
    String? title,
    String? description,
    String? location,
    String? barangay,
    double? latitude,
    double? longitude,
    String? photoUrl,
    ReportStatus? status,
    int? upvotes,
    DateTime? createdAt,
    bool? hasUpvoted,
  }) {
    return CommunityReport(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      barangay: barangay ?? this.barangay,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      photoUrl: photoUrl ?? this.photoUrl,
      status: status ?? this.status,
      upvotes: upvotes ?? this.upvotes,
      createdAt: createdAt ?? this.createdAt,
      hasUpvoted: hasUpvoted ?? this.hasUpvoted,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'category': category,
    'title': title,
    'description': description,
    'location': location,
    'barangay': barangay,
    'latitude': latitude,
    'longitude': longitude,
    'photoUrl': photoUrl,
    'status': status.name,
    'upvotes': upvotes,
    'createdAt': createdAt.toIso8601String(),
    'hasUpvoted': hasUpvoted,
  };

  factory CommunityReport.fromJson(Map<String, dynamic> json) => CommunityReport(
    id: json['id'] as String,
    category: json['category'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    location: json['location'] as String,
    barangay: json['barangay'] as String?,
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
    photoUrl: json['photoUrl'] as String?,
    status: ReportStatus.values.byName(json['status'] as String),
    upvotes: json['upvotes'] as int? ?? 0,
    createdAt: DateTime.parse(json['createdAt'] as String),
    hasUpvoted: json['hasUpvoted'] as bool? ?? false,
  );
}
