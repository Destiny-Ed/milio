import 'package:flutter/material.dart';
import 'package:milio/core/widgets/buttons.dart';
import 'package:milio/core/widgets/app_card.dart';

class ChangeRequest {
  final String type;
  final String description;
  final double? newBudget;

  ChangeRequest({required this.type, required this.description, this.newBudget});
}

class ChangeRequestScreen extends StatefulWidget {
  const ChangeRequestScreen({super.key});

  @override
  State<ChangeRequestScreen> createState() => _ChangeRequestScreenState();
}

class _ChangeRequestScreenState extends State<ChangeRequestScreen> {
  final List<ChangeRequest> requests = [];

  void createBudgetIncrease() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Increase Budget"),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: "New budget"),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            PrimaryButton(
              text: "Send Request",
              onTap: () {
                setState(() {
                  requests.add(
                    ChangeRequest(
                      type: "budget_increase",
                      description: "Request to increase budget",
                      newBudget: double.tryParse(controller.text),
                    ),
                  );
                });

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void approveRequest(int index) {
    setState(() {
      requests.removeAt(index);
    });
  }

  void rejectRequest(int index) {
    setState(() {
      requests.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Requests"),
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: createBudgetIncrease)],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: requests.isEmpty
            ? [const Center(child: Text("No requests yet"))]
            : requests.asMap().entries.map((e) {
                final i = e.key;
                final r = e.value;

                return AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r.type.toUpperCase()),
                      const SizedBox(height: 6),
                      Text(r.description),
                      if (r.newBudget != null) Text("New Budget: ₦${r.newBudget}"),
                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => rejectRequest(i),
                              child: const Text("Reject"),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: PrimaryButton(text: "Approve", onTap: () => approveRequest(i)),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
      ),
    );
  }
}
