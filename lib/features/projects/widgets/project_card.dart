import 'package:flutter/material.dart';
import 'package:milio/core/theme.dart';

import '../../../../core/widgets/app_card.dart';

class ProjectHeroCard extends StatelessWidget {
  final String title;
  final double budget;
  final double progress;
  final int completedMilestones;
  final int totalMilestones;

  const ProjectHeroCard({
    super.key,
    required this.title,
    required this.budget,
    required this.progress,
    required this.completedMilestones,
    required this.totalMilestones,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Text(
                  "${(progress * 100).toInt()}% Complete",
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ),
              Text(
                "$completedMilestones/$totalMilestones Milestones",
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppColors.border,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppColors.softBlue, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Icon(Icons.lock, color: AppColors.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "₦${budget.toStringAsFixed(0)} Locked in Escrow",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
