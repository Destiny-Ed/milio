enum UserRole { client, freelancer }

class User {
  final String uid;
  final String fullName;
  final UserRole role;
  final String email;
  final double walletBalance;
  final double totalEarned;
  final double pendingWithdrawals;

  User({
    required this.uid,
    required this.fullName,
    required this.role,
    required this.email,
    this.walletBalance = 0.0,
    this.totalEarned = 0.0,
    this.pendingWithdrawals = 0.0,
  });
}
