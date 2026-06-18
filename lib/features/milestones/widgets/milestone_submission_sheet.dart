import 'package:flutter/material.dart';
import 'package:milio/core/widgets/buttons.dart';

class MilestoneSubmissionSheet extends StatelessWidget {
  final Function(String note) onSubmit;

  const MilestoneSubmissionSheet({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Submit Milestone", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

          const SizedBox(height: 12),

          TextField(
            controller: controller,
            maxLines: 4,
            decoration: const InputDecoration(hintText: "Describe what you completed..."),
          ),

          const SizedBox(height: 20),

          PrimaryButton(
            text: "Submit Work",
            onTap: () {
              onSubmit(controller.text);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
