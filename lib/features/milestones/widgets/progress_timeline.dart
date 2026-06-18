import 'package:flutter/material.dart';
import 'package:milio/core/theme.dart';

class ProgressTimeline extends StatelessWidget {
  final List<String> milestones;
  final int currentIndex;

  const ProgressTimeline({super.key, required this.milestones, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(milestones.length, (index) {
        final completed = index < currentIndex;

        final active = index == currentIndex;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: completed
                      ? AppColors.success
                      : active
                      ? AppColors.warning
                      : Colors.grey.shade300,
                  child: Icon(completed ? Icons.check : Icons.circle, size: 12, color: Colors.white),
                ),
                if (index != milestones.length - 1)
                  Container(width: 2, height: 40, color: Colors.grey.shade300),
              ],
            ),

            const SizedBox(width: 12),

            Padding(padding: const EdgeInsets.only(top: 4), child: Text(milestones[index])),
          ],
        );
      }),
    );
  }
}
