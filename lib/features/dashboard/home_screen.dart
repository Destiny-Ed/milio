import 'package:flutter/material.dart';
import 'package:milio/features/notification/notification_screen.dart';
import 'package:provider/provider.dart';

import '../../core/theme.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/search_field.dart';
import '../../core/widgets/buttons.dart';

import '../../providers/app_provider.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) {
        final isClient = appState.isClientMode;
        final isAdmin = appState.isAdmin;

        return Scaffold(
          backgroundColor: AppColors.background,

          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            title: Text(_title(appState)),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationsScreen(userId: "userId")),
                  );
                },
              ),
            ],
          ),

          body: ListView(
            padding: const EdgeInsets.all(AppSpacing.sm),
            children: [
              /// HERO GREETING
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_greeting(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

                    const SizedBox(height: 6),

                    Text(
                      _subtitle(isClient, isAdmin),
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),

                    const SizedBox(height: 10),

                    PrimaryButton(text: isClient ? "Create Project" : "View Assignments", onTap: () {}),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// SEARCH (kept minimal)
              // const SearchField(hint: "Search projects, milestones..."),

              // const SizedBox(height: 20),

              /// STATS HEADER
              Text("Overview", style: Theme.of(context).textTheme.titleMedium),

              const SizedBox(height: 12),

              _stats(appState),

              const SizedBox(height: 16),

              /// QUICK ACTIONS HEADER
              Text("Quick Actions", style: Theme.of(context).textTheme.titleMedium),

              const SizedBox(height: 12),

              _actions(isClient, isAdmin),

              const SizedBox(height: 16),

              /// RECENT HEADER
              Text(
                isAdmin ? "System Activity" : "Recent Activity",
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(height: 12),

              _recent(isClient, isAdmin),
            ],
          ),
        );
      },
    );
  }

  // TITLE

  String _title(AppState state) {
    if (state.isAdmin) return "Admin";
    return state.isClientMode ? "Client" : "Freelancer";
  }

  // GREETING

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good morning 👋";
    if (hour < 18) return "Good afternoon 👋";
    return "Good evening 👋";
  }

  String _subtitle(bool isClient, bool isAdmin) {
    if (isAdmin) return "Monitor system activity and escrow flow";
    if (isClient) return "Manage projects and release payments safely";
    return "Track milestones and get paid securely";
  }

  // STATS

  Widget _stats(AppState state) {
    final isClient = state.isClientMode;
    final isAdmin = state.isAdmin;

    return Row(
      children: [
        Expanded(
          child: _statCard(
            title: isAdmin
                ? "Users"
                : isClient
                ? "Projects"
                : "Jobs",
            value: "12",
            icon: Icons.bar_chart,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            title: isAdmin ? "Escrow Volume" : "Locked Funds",
            value: "₦2.4M",
            icon: Icons.lock,
          ),
        ),
      ],
    );
  }

  Widget _statCard({required String title, required String value, required IconData icon}) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  // ACTIONS (CLEANED)

  Widget _actions(bool isClient, bool isAdmin) {
    return Row(
      children: [
        Expanded(
          child: _actionCard(icon: Icons.work_outline, label: isClient ? "Projects" : "Tasks"),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _actionCard(icon: Icons.account_balance_wallet, label: isAdmin ? "Finance" : "Wallet"),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _actionCard(icon: Icons.notifications_none, label: "Alerts"),
        ),
      ],
    );
  }

  Widget _actionCard({required IconData icon, required String label}) {
    return AppCard(
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // RECENT

  Widget _recent(bool isClient, bool isAdmin) {
    return Column(
      children: List.generate(3, (i) {
        return AppCard(
          margin: EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.softBlue,
              child: Icon(isAdmin ? Icons.shield : Icons.work, color: AppColors.primary),
            ),
            title: Text(
              isAdmin
                  ? "System Event #$i"
                  : isClient
                  ? "Project #$i"
                  : "Task #$i",
            ),
            subtitle: const Text("Updated recently", style: TextStyle(color: AppColors.textSecondary)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
          ),
        );
      }),
    );
  }
}
