import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dabawenyos/core/data/mock_data.dart';
import 'package:dabawenyos/features/reports/domain/community_report.dart';
import 'package:dabawenyos/features/announcements/domain/announcement.dart';
import 'package:dabawenyos/features/events/domain/city_event.dart';
import 'package:dabawenyos/features/emergency/domain/emergency_contact.dart';
import 'package:dabawenyos/features/explore/domain/explore_models.dart';

// --- Reports State ---
class ReportsNotifier extends Notifier<List<CommunityReport>> {
  @override
  List<CommunityReport> build() {
    return MockData.initialReports;
  }

  void toggleUpvote(String reportId) {
    state = [
      for (final r in state)
        if (r.id == reportId)
          r.copyWith(
            upvotes: r.hasUpvoted ? r.upvotes - 1 : r.upvotes + 1,
            hasUpvoted: !r.hasUpvoted,
          )
        else
          r,
    ];
  }

  void addReport({
    required String category,
    required String title,
    required String description,
    required String location,
    String? barangay,
  }) {
    final newReport = CommunityReport(
      id: 'rep-${DateTime.now().millisecondsSinceEpoch}',
      category: category,
      title: title,
      description: description,
      location: location,
      barangay: barangay,
      status: ReportStatus.submitted,
      upvotes: 0,
      createdAt: DateTime.now(),
    );
    state = [newReport, ...state];
  }
}

final reportsProvider = NotifierProvider<ReportsNotifier, List<CommunityReport>>(() {
  return ReportsNotifier();
});

// --- Announcements State ---
class AnnouncementsNotifier extends Notifier<List<Announcement>> {
  @override
  List<Announcement> build() {
    return MockData.initialAnnouncements;
  }

  void toggleBookmark(String id) {
    state = [
      for (final a in state)
        if (a.id == id)
          a.copyWith(isBookmarked: !a.isBookmarked)
        else
          a,
    ];
  }
}

final announcementsProvider = NotifierProvider<AnnouncementsNotifier, List<Announcement>>(() {
  return AnnouncementsNotifier();
});

// --- Events State ---
class EventsNotifier extends Notifier<List<CityEvent>> {
  @override
  List<CityEvent> build() {
    return MockData.initialEvents;
  }

  void toggleSave(String id) {
    state = [
      for (final e in state)
        if (e.id == id)
          e.copyWith(isSaved: !e.isSaved)
        else
          e,
    ];
  }
}

final eventsProvider = NotifierProvider<EventsNotifier, List<CityEvent>>(() {
  return EventsNotifier();
});

// --- Jobs State ---
class JobsNotifier extends Notifier<List<JobListing>> {
  @override
  List<JobListing> build() {
    return MockData.initialJobs;
  }

  void toggleSave(String id) {
    state = [
      for (final j in state)
        if (j.id == id)
          j.copyWith(isSaved: !j.isSaved)
        else
          j,
    ];
  }
}

final jobsProvider = NotifierProvider<JobsNotifier, List<JobListing>>(() {
  return JobsNotifier();
});

// --- Marketplace State ---
class MarketplaceNotifier extends Notifier<List<MarketplaceListing>> {
  @override
  List<MarketplaceListing> build() {
    return MockData.initialMarketplace;
  }

  void toggleFavorite(String id) {
    state = [
      for (final m in state)
        if (m.id == id)
          m.copyWith(isFavorite: !m.isFavorite)
        else
          m,
    ];
  }
}

final marketplaceProvider = NotifierProvider<MarketplaceNotifier, List<MarketplaceListing>>(() {
  return MarketplaceNotifier();
});

// --- Static Providers ---
final emergencyContactsProvider = Provider<List<EmergencyContact>>((ref) {
  return MockData.emergencyContacts;
});

final govOfficesProvider = Provider<List<GovOffice>>((ref) {
  return MockData.govOffices;
});

final trafficUpdatesProvider = Provider<List<TrafficUpdate>>((ref) {
  return MockData.trafficUpdates;
});

final floodReportsProvider = Provider<List<FloodReport>>((ref) {
  return MockData.floodReports;
});
