import 'package:flutter/material.dart';
import 'package:milio/core/theme.dart';
import 'package:milio/models/notification_model.dart';
import 'package:milio/services/notification_service.dart';
import '../../core/widgets/app_card.dart';

class NotificationsScreen extends StatelessWidget {
  final String userId;

  const NotificationsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final notifications = NotificationService.getAll(userId);

    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final n = notifications[index];

          return AppCard(
            child: ListTile(
              leading: Icon(_icon(n.type), color: _color(n.type)),
              title: Text(n.title),
              subtitle: Text(n.message),
              trailing: Text(
                _timeAgo(n.createdAt),
                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              onTap: () {
                NotificationService.markAsRead(n.id);
              },
            ),
          );
        },
      ),
    );
  }

  IconData _icon(NotificationType type) {
    switch (type) {
      case NotificationType.invite:
        return Icons.mail;
      case NotificationType.milestoneSubmitted:
        return Icons.upload;
      case NotificationType.milestoneApproved:
        return Icons.check_circle;
      case NotificationType.milestoneRejected:
        return Icons.cancel;
      case NotificationType.paymentReleased:
        return Icons.payments;
      case NotificationType.escrowFunded:
        return Icons.lock;
      case NotificationType.withdrawalRequested:
        return Icons.download;
      case NotificationType.withdrawalApproved:
        return Icons.verified;
    }
  }

  Color _color(NotificationType type) {
    switch (type) {
      case NotificationType.milestoneApproved:
      case NotificationType.paymentReleased:
      case NotificationType.withdrawalApproved:
        return Colors.green;

      case NotificationType.milestoneRejected:
        return Colors.red;

      case NotificationType.invite:
        return Colors.blue;

      default:
        return Colors.orange;
    }
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes}m ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours}h ago";
    } else {
      return "${diff.inDays}d ago";
    }
  }
}
