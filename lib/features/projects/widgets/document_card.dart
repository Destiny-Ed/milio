import 'package:flutter/material.dart';
import 'package:milio/core/theme.dart';
import '../../../../core/widgets/app_card.dart';

class DocumentCard extends StatelessWidget {
  final String title;
  final String type;

  const DocumentCard({super.key, required this.title, required this.type});

  IconData get icon {
    switch (type) {
      case "pdf":
        return Icons.picture_as_pdf;
      case "image":
        return Icons.image;
      default:
        return Icons.insert_drive_file;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14),
        ],
      ),
    );
  }
}
