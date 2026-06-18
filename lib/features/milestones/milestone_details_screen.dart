import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:milio/core/theme.dart';
import 'package:milio/core/widgets/buttons.dart';
import 'package:milio/core/widgets/app_card.dart';

import '../../providers/app_provider.dart';

class MilestoneDetailScreen extends StatefulWidget {
  final String title;
  final double amount;
  final String status;

  const MilestoneDetailScreen({super.key, required this.title, required this.amount, required this.status});

  @override
  State<MilestoneDetailScreen> createState() => _MilestoneDetailScreenState();
}

class _MilestoneDetailScreenState extends State<MilestoneDetailScreen> {
  bool approved = false;
  bool rejected = false;

  final TextEditingController commentController = TextEditingController();

  final List<Map<String, dynamic>> attachments = [
    {"name": "API Documentation.pdf", "type": "pdf"},
    {"name": "UI Screenshots.png", "type": "image"},
    {"name": "Backend Demo.mp4", "type": "video"},
  ];

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  // ---------------- ROLE LOGIC ----------------

  bool _canApprove(bool isClient, bool isAdmin) {
    return isClient || isAdmin;
  }

  bool _canSubmit(bool isClient) {
    return !isClient;
  }

  // ---------------- ACTIONS ----------------

  void _approve() {
    setState(() {
      approved = true;
      rejected = false;
    });

    _toast("Milestone Approved ✔");
  }

  void _reject() {
    setState(() {
      rejected = true;
      approved = false;
    });

    _toast("Milestone Rejected ✖");
  }

  void _sendComment() {
    if (commentController.text.isEmpty) return;

    _toast("Comment sent");
    commentController.clear();
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) {
        final isClient = appState.isClientMode;
        final isAdmin = appState.isAdmin;
        final isFreelancer = !isClient;

        final canApprove = _canApprove(isClient, isAdmin);
        final canSubmit = _canSubmit(isClient);

        return Scaffold(
          backgroundColor: AppColors.background,

          appBar: AppBar(title: const Text("Milestone"), backgroundColor: AppColors.background, elevation: 0),

          bottomNavigationBar: _bottomBar(canApprove: canApprove, canSubmit: canSubmit),

          body: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              /// HEADER
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                    const SizedBox(height: 10),

                    Text(
                      "₦${widget.amount.toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),

                    const SizedBox(height: 10),

                    _statusChip(widget.status),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// DESCRIPTION
              const Text("Submission Notes", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),

              const SizedBox(height: 10),

              const AppCard(
                child: Text(
                  "Backend APIs completed with authentication, database integration, and payment logic. Fully tested and documented.",
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),

              const SizedBox(height: 20),

              /// ATTACHMENTS
              const Text("Attachments", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),

              const SizedBox(height: 10),

              ...attachments.map((file) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AppCard(
                    child: Row(
                      children: [
                        Icon(_fileIcon(file["type"]), color: AppColors.primary),
                        const SizedBox(width: 12),
                        Expanded(child: Text(file["name"])),
                        const Icon(Icons.arrow_forward_ios, size: 14),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 20),

              /// COMMENT
              const Text("Review Comment", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),

              const SizedBox(height: 10),

              AppCard(
                child: Column(
                  children: [
                    TextField(
                      controller: commentController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: "Write feedback or request changes...",
                        border: InputBorder.none,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: _sendComment, child: const Text("Send")),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        );
      },
    );
  }

  // ---------------- BOTTOM BAR ----------------

  Widget _bottomBar({required bool canApprove, required bool canSubmit}) {
    if (approved || rejected) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SafeArea(
          child: Text(
            approved ? "Milestone Approved ✔" : "Milestone Rejected ✖",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: approved ? AppColors.success : AppColors.error,
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            /// CLIENT / ADMIN ACTIONS
            if (canApprove) ...[
              Expanded(
                child: OutlinedButton(onPressed: _reject, child: const Text("Reject")),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PrimaryButton(text: "Approve", onTap: _approve),
              ),
            ],

            /// FREELANCER ACTIONS
            if (canSubmit) ...[
              Expanded(
                child: PrimaryButton(text: "Submit Work", onTap: () => _toast("Work submitted for review")),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ---------------- HELPERS ----------------

  Widget _statusChip(String status) {
    Color color;

    switch (status) {
      case "approved":
        color = AppColors.success;
        break;
      case "submitted":
        color = AppColors.warning;
        break;
      case "active":
        color = AppColors.primary;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }

  IconData _fileIcon(String type) {
    switch (type) {
      case "pdf":
        return Icons.picture_as_pdf;
      case "image":
        return Icons.image;
      case "video":
        return Icons.video_file;
      default:
        return Icons.insert_drive_file;
    }
  }
}
