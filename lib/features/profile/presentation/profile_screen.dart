import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dabawenyos/core/theme/app_theme.dart';
import 'package:dabawenyos/core/providers/app_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reports = ref.watch(reportsProvider);
    final announcements = ref.watch(announcementsProvider);
    final bookmarkedNews = announcements.where((a) => a.isBookmarked).length;

    final events = ref.watch(eventsProvider);
    final savedEvents = events.where((e) => e.isSaved).length;

    final jobs = ref.watch(jobsProvider);
    final savedJobs = jobs.where((j) => j.isSaved).length;

    final marketplace = ref.watch(marketplaceProvider);
    final savedMkt = marketplace.where((m) => m.isFavorite).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Profile & Preferences'),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // User Avatar Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.primarySurface,
                    child: const Icon(Icons.person, size: 36, color: AppColors.primary),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dabawenyo Citizen',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'District 1 • Davao City',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Prototype Guest Session',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.emerald,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Saved Items Overview Grid
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Reports Filed',
                    count: '${reports.length}',
                    icon: Icons.campaign_outlined,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _StatCard(
                    title: 'Saved Advisories',
                    count: '$bookmarkedNews',
                    icon: Icons.bookmark_border,
                    color: AppColors.warning,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Saved Events',
                    count: '$savedEvents',
                    icon: Icons.event_available,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _StatCard(
                    title: 'Saved Jobs',
                    count: '$savedJobs',
                    icon: Icons.work_outline,
                    color: AppColors.emerald,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Settings & App Info
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.favorite_border, color: AppColors.error),
                    title: const Text('Marketplace Watchlist', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    trailing: Text('$savedMkt items', style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.notifications_none, color: AppColors.primary),
                    title: const Text('Advisory Notifications', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    trailing: const Text('Enabled', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.verified_user_outlined, color: Colors.teal),
                    title: const Text('Privacy & Data Governance', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    trailing: const Icon(Icons.chevron_right, size: 18),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Privacy & Independent Platform'),
                          content: const Text(
                            'Dabawenyos is an independent open civic platform. '
                            'User data entered into this prototype remains strictly on this device and is not sent to external servers without user configuration.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.info_outline, color: AppColors.textSecondary),
                    title: const Text('About Dabawenyos', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    subtitle: const Text('One App. One City. • v1.0.0-prototype', style: TextStyle(fontSize: 11)),
                    trailing: const Icon(Icons.chevron_right, size: 18),
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'Dabawenyos',
                        applicationVersion: '1.0.0+1',
                        applicationLegalese: 'Civic Technology Architecture for Davao City, Philippines. Not an official government app.',
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
