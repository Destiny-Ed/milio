import 'package:flutter/material.dart';
import 'package:milio/core/theme.dart';
import 'package:milio/core/widgets/buttons.dart';
import '../../core/widgets/app_card.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  int step = 0;

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final budgetController = TextEditingController();

  String allocationMode = "percentage"; // percentage | fixed

  List<MilestoneInput> milestones = [];

  double get totalPercentage {
    return milestones.fold(0, (sum, m) => sum + m.percentage);
  }

  double get totalAmount {
    return milestones.fold(0, (sum, m) => sum + m.amount);
  }

  bool get isPercentageValid => totalPercentage == 100;

  bool get isFixedValid {
    final budget = double.tryParse(budgetController.text) ?? 0;
    return totalAmount == budget;
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    budgetController.dispose();
    super.dispose();
  }

  void addMilestone() {
    setState(() {
      milestones.add(MilestoneInput());
    });
  }

  void removeMilestone(int index) {
    setState(() {
      milestones.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(title: const Text("Create Project"), backgroundColor: AppColors.background),

      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            /// STEP INDICATOR
            Row(
              children: [
                _stepCircle(0, "Info"),
                _line(),
                _stepCircle(1, "Milestones"),
                _line(),
                _stepCircle(2, "Review"),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(child: _buildStep()),

            const SizedBox(height: 10),

            /// NAVIGATION BUTTONS
            Row(
              children: [
                if (step > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() => step--);
                      },
                      child: const Text("Back"),
                    ),
                  ),

                if (step > 0) const SizedBox(width: 12),

                Expanded(
                  child: PrimaryButton(
                    text: step == 2 ? "Create Project" : "Next",
                    onTap: () {
                      if (step == 0) {
                        setState(() => step = 1);
                      } else if (step == 1) {
                        setState(() => step = 2);
                      } else {
                        _submit();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (step) {
      case 0:
        return _projectInfoStep();
      case 1:
        return _milestoneStep();
      default:
        return _reviewStep();
    }
  }

  /// STEP 1
  Widget _projectInfoStep() {
    return ListView(
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Project Title"),
              const SizedBox(height: 8),
              TextField(controller: titleController),
              const SizedBox(height: 16),

              const Text("Description"),
              const SizedBox(height: 8),
              TextField(controller: descController, maxLines: 3),
              const SizedBox(height: 16),

              const Text("Total Budget"),
              const SizedBox(height: 8),
              TextField(controller: budgetController, keyboardType: TextInputType.number),
            ],
          ),
        ),
      ],
    );
  }

  /// STEP 2
  Widget _milestoneStep() {
    final budget = double.tryParse(budgetController.text) ?? 0;

    return ListView(
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Milestone Allocation Mode", style: TextStyle(fontWeight: FontWeight.bold)),

              const SizedBox(height: 12),

              Row(
                children: [
                  ChoiceChip(
                    label: const Text("Percentage"),
                    selected: allocationMode == "percentage",
                    onSelected: (_) {
                      setState(() => allocationMode = "percentage");
                    },
                  ),
                  const SizedBox(width: 10),
                  ChoiceChip(
                    label: const Text("Fixed Amount"),
                    selected: allocationMode == "fixed",
                    onSelected: (_) {
                      setState(() => allocationMode = "fixed");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        AppCard(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Milestones", style: TextStyle(fontWeight: FontWeight.bold)),
                  IconButton(onPressed: addMilestone, icon: const Icon(Icons.add)),
                ],
              ),

              const SizedBox(height: 10),

              ...milestones.asMap().entries.map((entry) {
                int i = entry.key;
                final m = entry.value;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(hintText: "Milestone title"),
                        onChanged: (v) => m.title = v,
                      ),
                      const SizedBox(height: 8),

                      if (allocationMode == "percentage")
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: "Percentage %"),
                          onChanged: (v) {
                            m.percentage = double.tryParse(v) ?? 0;
                            setState(() {});
                          },
                        )
                      else
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: "Amount (₦)"),
                          onChanged: (v) {
                            m.amount = double.tryParse(v) ?? 0;
                            setState(() {});
                          },
                        ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(onPressed: () => removeMilestone(i), child: const Text("Remove")),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 12),

              /// VALIDATION SUMMARY
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.softBlue, borderRadius: BorderRadius.circular(12)),
                child: allocationMode == "percentage"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total: ${totalPercentage.toStringAsFixed(0)}%"),
                          Text(
                            isPercentageValid ? "Valid ✔" : "Must equal 100%",
                            style: TextStyle(color: isPercentageValid ? Colors.green : Colors.red),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Allocated: ₦${totalAmount.toStringAsFixed(0)}"),
                          Text("Budget: ₦$budget"),
                          Text(
                            isFixedValid ? "Valid ✔" : "Mismatch!",
                            style: TextStyle(color: isFixedValid ? Colors.green : Colors.red),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// STEP 3
  Widget _reviewStep() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Title: ${titleController.text}"),
          const SizedBox(height: 8),
          Text("Budget: ₦${budgetController.text}"),
          const SizedBox(height: 12),
          const Text("Milestones:", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...milestones.map(
            (m) => Text(
              "• ${m.title} (${allocationMode == "percentage" ? "${m.percentage}%" : "₦${m.amount}"})",
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepCircle(int index, String label) {
    final active = step == index;

    return Column(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: active ? AppColors.primary : Colors.grey.shade300,
          child: Text("${index + 1}", style: const TextStyle(color: Colors.white, fontSize: 12)),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _line() {
    return const Expanded(child: Divider(thickness: 1));
  }

  void _submit() {
    final valid = allocationMode == "percentage" ? isPercentageValid : isFixedValid;

    if (!valid) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Fix milestone allocation first")));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Project Created 🚀")));

    Navigator.pop(context);
  }
}

/// MODEL
class MilestoneInput {
  String title = "";
  double percentage = 0;
  double amount = 0;
}
