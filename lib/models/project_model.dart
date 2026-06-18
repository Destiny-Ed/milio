import 'package:milio/core/enums.dart';

import 'milestone_model.dart';

class Project {
  final String id;
  final String title;
  final String clientName;
  final String freelancerId;
  final double totalBudget;
  final String status; // draft, funded, in_progress, completed, cancelled
  final List<Milestone> milestones;
  final ProjectState state;
  final DateTime createdAt;

  double? progress;

  Project({
    required this.id,
    required this.title,
    required this.clientName,
    required this.freelancerId,
    required this.totalBudget,
    this.status = 'in_progress',
    required this.milestones,
    required this.createdAt,
    required this.state,
    this.progress = 0,
  });

  double get platformBalance =>
      milestones.where((m) => m.status != 'approved').fold(0.0, (sum, m) => sum + m.amount);
}
