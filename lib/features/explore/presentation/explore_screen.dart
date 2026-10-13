import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dabawenyos/core/theme/app_theme.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Explore Davao City'),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map Abstraction Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primarySurface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.map_outlined, color: AppColors.primary),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'City Map Provider (Abstracted)',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              'OpenStreetMap / Google Maps ready',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.location_searching, size: 32, color: AppColors.primary.withValues(alpha: 0.6)),
                          const SizedBox(height: 6),
                          const Text(
                            'Davao City Geo-Coordinate Layer',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                          ),
                          const Text(
                            '7.1907° N, 125.4553° E',
                            style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Explore Modules',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),

            _ExploreModuleCard(
              title: 'Government Directory',
              subtitle: 'Offices, document requirements, operating hours',
              icon: Icons.account_balance,
              iconColor: Colors.teal,
              onTap: () => context.push('/directory'),
            ),
            const SizedBox(height: 10),

            _ExploreModuleCard(
              title: 'Traffic & Flood Monitoring',
              subtitle: 'Road passability, detours, and flood levels',
              icon: Icons.traffic,
              iconColor: AppColors.warning,
              onTap: () => context.push('/traffic-flood'),
            ),
            const SizedBox(height: 10),

            _ExploreModuleCard(
              title: 'Local Job Opportunities',
              subtitle: 'Davao corporate, part-time & government vacancies',
              icon: Icons.work_outline,
              iconColor: AppColors.emerald,
              onTap: () => context.push('/jobs'),
            ),
            const SizedBox(height: 10),

            _ExploreModuleCard(
              title: 'Local Marketplace',
              subtitle: 'Davao produce, crafts, appliances, and food',
              icon: Icons.storefront,
              iconColor: Colors.orange,
              onTap: () => context.push('/marketplace'),
            ),
            const SizedBox(height: 10),

            _ExploreModuleCard(
              title: 'Events & Festivals',
              subtitle: 'Kadayawan, job fairs, medical missions & expos',
              icon: Icons.event,
              iconColor: Colors.purple,
              onTap: () => context.push('/events'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExploreModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _ExploreModuleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}
