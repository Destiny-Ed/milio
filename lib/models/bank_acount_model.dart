class BankAccount {
  final String id;
  final String bankName;
  final String accountNumber;
  final String accountName;
  final bool isPrimary;

  BankAccount({
    required this.id,
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
    this.isPrimary = false,
  });
}
