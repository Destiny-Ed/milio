class WalletTransaction {
  final String id;
  final String type; // credit, debit
  final double amount;
  final String description;
  final DateTime date;

  WalletTransaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.date,
  });
}
