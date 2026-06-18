class Milestone {
  final String id;
  final String title;
  final double percentage;
  final double amount;
  final String status; // pending, submitted, approved, rejected
  final String? submissionNote;
  final DateTime? submittedAt;
  final DateTime? approvedAt;

  Milestone({
    required this.id,
    required this.title,
    required this.percentage,
    required this.amount,
    this.status = 'pending',
    this.submissionNote,
    this.submittedAt,
    this.approvedAt,
  });
}
