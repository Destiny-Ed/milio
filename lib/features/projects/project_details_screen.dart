import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:milio/core/theme.dart';
import 'package:milio/core/widgets/buttons.dart';

import 'package:milio/features/invite/invite_freelancer_sheet.dart';
import 'package:milio/features/milestones/milestone_details_screen.dart';

import 'package:milio/features/projects/widgets/activity_card.dart';
import 'package:milio/features/projects/widgets/document_card.dart';
import 'package:milio/features/projects/widgets/escrow_summary_card.dart';
import 'package:milio/features/projects/widgets/milestone_card.dart';
import 'package:milio/features/projects/widgets/project_card.dart';
import 'package:milio/features/projects/widgets/section_header.dart';

import 'package:milio/models/notification_model.dart';
import 'package:milio/services/notification_service.dart';

import '../../providers/app_provider.dart';

class ProjectDetailScreen extends StatefulWidget {
  final String title;
  final double budget;

  const ProjectDetailScreen({super.key, required this.title, required this.budget});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  int currentMilestoneIndex = 1;

  final List<Map<String, dynamic>> milestones = [
    {"title": "Discovery", "status": "approved", "amount": 100000},
    {"title": "UI Design", "status": "approved", "amount": 150000},
    {"title": "Backend", "status": "submitted", "amount": 200000},
    {"title": "Testing", "status": "pending", "amount": 30000},
    {"title": "Deploy", "status": "pending", "amount": 20000},
  ];

  double get progress => currentMilestoneIndex / milestones.length;

  double get releasedAmount {
    double total = 0;
    for (int i = 0; i < currentMilestoneIndex; i++) {
      total += (milestones[i]["amount"] as num);
    }
    return total;
  }

  double get remainingAmount => widget.budget - releasedAmount;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) {
        final isClient = appState.isClientMode;
        final isAdmin = appState.isAdmin;
        final isFreelancer = !isClient;

        return Scaffold(
          backgroundColor: AppColors.background,

          appBar: AppBar(
            title: Text(_title(isClient, isAdmin)),
            backgroundColor: AppColors.background,
            elevation: 0,
          ),

          bottomNavigationBar: _bottomBar(isClient, isAdmin, isFreelancer),

          body: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              /// HERO (ROLE CONTEXTUAL)
              ProjectHeroCard(
                title: widget.title,
                budget: widget.budget,
                progress: progress,
                completedMilestones: currentMilestoneIndex,
                totalMilestones: milestones.length,
              ),

              const SizedBox(height: 16),

              /// ESCROW (KEY FINTECH ELEMENT)
              EscrowSummaryCard(locked: widget.budget, released: releasedAmount, remaining: remainingAmount),

              const SizedBox(height: 24),

              /// ROLE INFO BANNER
              _roleBanner(isClient, isAdmin),

              const SizedBox(height: 20),

              /// MILESTONES
              const SectionHeader(title: "Milestones"),
              const SizedBox(height: 12),

              ...milestones.asMap().entries.map((entry) {
                final index = entry.key;
                final m = entry.value;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: MilestoneCard(
                    title: m["title"],
                    status: m["status"],
                    amount: (m["amount"] as num).toDouble(),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MilestoneDetailScreen(
                            title: m["title"],
                            amount: (m["amount"] as num).toDouble(),
                            status: m["status"],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),

              const SizedBox(height: 20),

              /// ACTIVITY
              const SectionHeader(title: "Activity"),
              const SizedBox(height: 12),

              const ActivityCard(
                title: "Latest Update",
                subtitle: "Milestone progress tracked securely",
                icon: Icons.timeline,
                color: Colors.blue,
              ),

              const SizedBox(height: 100),
            ],
          ),
        );
      },
    );
  }

  // ---------------- ROLE TITLE ----------------

  String _title(bool isClient, bool isAdmin) {
    if (isAdmin) return "Admin Project View";
    return isClient ? "Client Project" : "Freelancer Project";
  }

  // ---------------- ROLE BANNER ----------------

  Widget _roleBanner(bool isClient, bool isAdmin) {
    String text;

    if (isAdmin) {
      text = "System monitoring escrow and milestones";
    } else if (isClient) {
      text = "You fund milestones and approve deliverables";
    } else {
      text = "You deliver work and get paid per milestone";
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, size: 18),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  // ---------------- BOTTOM BAR ----------------

  Widget _bottomBar(bool isClient, bool isAdmin, bool isFreelancer) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            /// CLIENT ACTIONS
            if (isClient || isAdmin) ...[
              Expanded(
                child: PrimaryButton(text: "Invite Freelancer", onTap: _invite),
              ),
            ],

            /// FREELANCER ACTIONS
            if (isFreelancer && !isClient) ...[
              Expanded(
                child: PrimaryButton(text: "Submit Work", onTap: _submitWork),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ---------------- ACTIONS ----------------

  void _invite() {
    showModalBottomSheet(
      context: context,
      builder: (_) => InviteFreelancerSheet(
        onInvite: (id) {
          NotificationService.add(
            AppNotification(
              id: DateTime.now().toString(),
              userId: "freelancerId",
              type: NotificationType.invite,
              title: "Project Invite",
              message: "You've been invited to a project",
              createdAt: DateTime.now(),
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invite sent to $id")));
        },
      ),
    );
  }

  void _submitWork() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Work submitted for review")));
  }
}
