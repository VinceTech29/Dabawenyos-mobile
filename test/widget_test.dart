import 'package:flutter_test/flutter_test.dart';
import 'package:dabawenyos/features/reports/domain/community_report.dart';
import 'package:dabawenyos/core/data/mock_data.dart';

void main() {
  group('CommunityReport Domain Tests', () {
    test('creates report and toggles upvote copyWith', () {
      final report = CommunityReport(
        id: 'test-1',
        category: 'Pothole',
        title: 'Road Damage',
        description: 'Large pothole on street',
        location: 'JP Laurel Ave',
        status: ReportStatus.submitted,
        upvotes: 5,
        createdAt: DateTime.now(),
      );

      expect(report.upvotes, 5);
      expect(report.hasUpvoted, false);

      final upvoted = report.copyWith(
        upvotes: report.upvotes + 1,
        hasUpvoted: true,
      );

      expect(upvoted.upvotes, 6);
      expect(upvoted.hasUpvoted, true);
    });

    test('serializes to and from JSON correctly', () {
      final original = CommunityReport(
        id: 'test-json',
        category: 'Flooding',
        title: 'Flood water rising',
        description: 'Near creek',
        location: 'Matina',
        barangay: 'Matina Pangi',
        status: ReportStatus.inProgress,
        upvotes: 12,
        createdAt: DateTime.parse('2026-10-13T10:00:00Z'),
        hasUpvoted: true,
      );

      final json = original.toJson();
      final reconstructed = CommunityReport.fromJson(json);

      expect(reconstructed.id, original.id);
      expect(reconstructed.category, original.category);
      expect(reconstructed.status, original.status);
      expect(reconstructed.upvotes, original.upvotes);
      expect(reconstructed.hasUpvoted, original.hasUpvoted);
    });
  });

  group('MockData Consistency Tests', () {
    test('contains verified Davao 911 emergency hotline', () {
      final contacts = MockData.emergencyContacts;
      final central911 = contacts.firstWhere((c) => c.isPrimary);
      expect(central911.number, '911');
      expect(central911.label, contains('911'));
    });

    test('mock announcements contain valid categories', () {
      final announcements = MockData.initialAnnouncements;
      expect(announcements.isNotEmpty, true);
      for (final a in announcements) {
        expect(a.title.isNotEmpty, true);
        expect(a.source.isNotEmpty, true);
      }
    });
  });
}
