import 'package:flutter/material.dart';
import 'package:milio/core/theme.dart';
import '../../../../core/widgets/app_card.dart';

class EscrowSummaryCard extends StatelessWidget {
  final double locked;
  final double released;
  final double remaining;

  const EscrowSummaryCard({super.key, required this.locked, required this.released, required this.remaining});

  Widget _item(String title, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          _item("Locked", "₦${locked.toStringAsFixed(0)}", AppColors.primary),
          _item("Released", "₦${released.toStringAsFixed(0)}", AppColors.success),
          _item("Remaining", "₦${remaining.toStringAsFixed(0)}", AppColors.warning),
        ],
      ),
    );
  }
}
