import 'package:milio/models/notification_model.dart';

class NotificationService {
  static final List<AppNotification> _notifications = [];

  static List<AppNotification> getAll(String userId) {
    return _notifications.where((n) => n.userId == userId).toList().reversed.toList();
  }

  static void add(AppNotification notification) {
    _notifications.add(notification);
  }

  static void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);

    if (index != -1) {
      final old = _notifications[index];
      _notifications[index] = AppNotification(
        id: old.id,
        userId: old.userId,
        type: old.type,
        title: old.title,
        message: old.message,
        createdAt: old.createdAt,
        isRead: true,
      );
    }
  }
}
