import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dabawenyos/core/theme/app_theme.dart';
import 'package:dabawenyos/core/providers/app_providers.dart';

class TrafficFloodScreen extends ConsumerStatefulWidget {
  const TrafficFloodScreen({super.key});

  @override
  ConsumerState<TrafficFloodScreen> createState() => _TrafficFloodScreenState();
}

class _TrafficFloodScreenState extends ConsumerState<TrafficFloodScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final traffic = ref.watch(trafficUpdatesProvider);
    final flood = ref.watch(floodReportsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Traffic & Flood Reports'),
        backgroundColor: AppColors.primary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Road Traffic'),
            Tab(text: 'Flood Levels'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Traffic Tab
          ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: traffic.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = traffic[index];
              Color statusColor = AppColors.success;
              if (item.status == 'closed') statusColor = AppColors.error;
              if (item.status == 'heavy') statusColor = AppColors.warning;
              if (item.status == 'moderate') statusColor = Colors.orange;

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.location,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: statusColor),
                            ),
                            child: Text(
                              item.status.toUpperCase(),
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: statusColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.detail,
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Updated: ${item.time}',
                        style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Flood Tab
          ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: flood.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = flood[index];
              Color levelColor = AppColors.success;
              if (item.level == 'impassable') levelColor = AppColors.error;
              if (item.level == 'waist') levelColor = Colors.deepOrange;
              if (item.level == 'knee') levelColor = AppColors.warning;

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Brgy. ${item.barangay}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: levelColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: levelColor),
                            ),
                            child: Text(
                              '${item.level.toUpperCase()} DEEP',
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: levelColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.place, size: 14, color: AppColors.textMuted),
                          const SizedBox(width: 4),
                          Text(item.street, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Reported by: ${item.reporter}',
                            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                          ),
                          Text(
                            item.time,
                            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
