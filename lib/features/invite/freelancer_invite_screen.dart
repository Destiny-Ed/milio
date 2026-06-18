import 'package:flutter/material.dart';
import 'package:milio/core/theme.dart';
import 'package:milio/core/widgets/buttons.dart';
import '../../core/widgets/app_card.dart';

class FreelancerInvitesScreen extends StatelessWidget {
  FreelancerInvitesScreen({super.key});

  final List<Map<String, dynamic>> invites = [
    {"project": "E-commerce App", "budget": 500000, "client": "John Doe"},
    {"project": "Fintech Dashboard", "budget": 300000, "client": "Sarah AI"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Project Invites")),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: invites.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final invite = invites[index];

          return AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(invite["project"], style: const TextStyle(fontWeight: FontWeight.bold)),

                const SizedBox(height: 6),

                Text("Client: ${invite["client"]}", style: const TextStyle(color: AppColors.textSecondary)),

                const SizedBox(height: 6),

                Text("₦${invite["budget"]}", style: const TextStyle(fontWeight: FontWeight.w600)),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(onPressed: () {}, child: const Text("Decline")),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PrimaryButton(text: "Accept", onTap: () {}),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
