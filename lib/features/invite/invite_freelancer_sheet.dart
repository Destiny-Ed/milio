import 'package:flutter/material.dart';
import 'package:milio/core/widgets/buttons.dart';

class InviteFreelancerSheet extends StatelessWidget {
  final Function(String freelancerId) onInvite;

  const InviteFreelancerSheet({super.key, required this.onInvite});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Invite Freelancer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

          const SizedBox(height: 12),

          TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Enter freelancer ID or email"),
          ),

          const SizedBox(height: 20),

          PrimaryButton(
            text: "Send Invite",
            onTap: () {
              onInvite(controller.text);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
