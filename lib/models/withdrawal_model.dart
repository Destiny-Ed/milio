class Withdrawal {
  final String id;
  final double amount;
  final String bankName;
  final String accountNumber;
  final String accountName;
  final String status; // pending, processing, paid, rejected
  final DateTime requestedAt;
  final String? rejectionReason;

  Withdrawal({
    required this.id,
    required this.amount,
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
    this.status = 'pending',
    required this.requestedAt,
    this.rejectionReason,
  });
}
