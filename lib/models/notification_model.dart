enum NotificationType {
  invite,
  milestoneSubmitted,
  milestoneApproved,
  milestoneRejected,
  paymentReleased,
  escrowFunded,
  withdrawalRequested,
  withdrawalApproved,
}

class AppNotification {
  final String id;
  final String userId;
  final NotificationType type;
  final String title;
  final String message;
  final DateTime createdAt;
  final bool isRead;

  AppNotification({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.message,
    required this.createdAt,
    this.isRead = false,
  });
}
