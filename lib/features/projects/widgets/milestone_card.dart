import 'package:flutter/material.dart';
import 'package:milio/core/theme.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/status_chip.dart';

class MilestoneCard extends StatelessWidget {
  final String title;
  final String status;
  final double amount;
  final VoidCallback? onTap;

  const MilestoneCard({
    super.key,
    required this.title,
    required this.status,
    required this.amount,
    this.onTap,
  });

  Color get statusColor {
    switch (status) {
      case "approved":
        return AppColors.success;

      case "submitted":
        return AppColors.warning;

      case "active":
        return AppColors.primary;

      default:
        return AppColors.textTertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                ),
                StatusChip(label: status, color: statusColor),
              ],
            ),

            const SizedBox(height: 12),

            Text(
              "₦${amount.toStringAsFixed(0)}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),

            const SizedBox(height: 12),

            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "View Details",
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, size: 16, color: AppColors.primary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
