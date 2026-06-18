import 'package:milio/models/milestone_model.dart';

class ChangeRequest {
  final String id;
  final String projectId;

  final String type;
  // "add_milestone" | "edit_milestone" | "increase_budget"

  final double? newBudget;
  final List<Milestone>? newMilestones;

  final String status;
  // pending | approved | rejected

  final String requestedBy;

  ChangeRequest({
    required this.id,
    required this.projectId,
    required this.type,
    this.newBudget,
    this.newMilestones,
    this.status = "pending",
    required this.requestedBy,
  });
}
