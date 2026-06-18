import 'package:flutter/material.dart';
import 'package:milio/core/theme.dart';
import 'package:milio/core/widgets/buttons.dart';

class BottomActionSheet {
  static void showReleasePayment(
    BuildContext context, {
    required String milestoneTitle,
    required double amount,
    required VoidCallback onConfirm,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Release Payment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

              const SizedBox(height: 12),

              Text(
                "You are about to release payment for:",
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textSecondary),
              ),

              const SizedBox(height: 8),

              Text(milestoneTitle, style: const TextStyle(fontWeight: FontWeight.w600)),

              const SizedBox(height: 8),

              Text(
                "₦${amount.toStringAsFixed(0)}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              PrimaryButton(
                text: "Confirm Release",
                onTap: () {
                  Navigator.pop(context);
                  onConfirm();
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
