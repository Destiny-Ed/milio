import 'package:milio/core/enums.dart';

class ProjectInvite {
  final String id;
  final String projectId;
  final String freelancerId;
  final String projectTitle;
  final double budget;
  final String status; // pending, accepted, declined
    final InvitationState state;
  final DateTime createdAt;

  ProjectInvite({
    required this.id,
    required this.projectId,
    required this.freelancerId,
    required this.projectTitle,
    required this.budget,
    required this.status,
    required this.state,
    required this.createdAt,
  });
}
