class CityEvent {
  final String id;
  final String title;
  final String description;
  final String dateDisplay; // e.g. "14–23"
  final String monthDisplay; // e.g. "AUG"
  final DateTime startDate;
  final String venue;
  final String location;
  final String category;
  final String organizer;
  final String? registrationUrl;
  final bool isSaved;

  const CityEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.dateDisplay,
    required this.monthDisplay,
    required this.startDate,
    required this.venue,
    required this.location,
    required this.category,
    required this.organizer,
    this.registrationUrl,
    this.isSaved = false,
  });

  CityEvent copyWith({
    String? id,
    String? title,
    String? description,
    String? dateDisplay,
    String? monthDisplay,
    DateTime? startDate,
    String? venue,
    String? location,
    String? category,
    String? organizer,
    String? registrationUrl,
    bool? isSaved,
  }) {
    return CityEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateDisplay: dateDisplay ?? this.dateDisplay,
      monthDisplay: monthDisplay ?? this.monthDisplay,
      startDate: startDate ?? this.startDate,
      venue: venue ?? this.venue,
      location: location ?? this.location,
      category: category ?? this.category,
      organizer: organizer ?? this.organizer,
      registrationUrl: registrationUrl ?? this.registrationUrl,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
