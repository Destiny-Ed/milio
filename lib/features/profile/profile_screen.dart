import 'package:flutter/material.dart';
import 'package:milio/core/theme.dart';
import 'package:milio/core/widgets/buttons.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/app_card.dart';

import '../../providers/app_provider.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) {
        final isClient = state.isClientMode;
        // final role = state.role;

        return Scaffold(
          appBar: AppBar(title: const Text("Profile & Settings")),

          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              /// PROFILE HEADER
              AppCard(
                child: Row(
                  children: [
                    const CircleAvatar(radius: 28, child: Icon(Icons.person)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("John Doe", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(
                            "Client".toUpperCase(),
                            style: const TextStyle(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// ROLE SWITCHER (CORE FEATURE)
              const Text("Account Mode", style: TextStyle(fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),

              AppCard(
                child: Column(
                  children: [
                    _modeTile(
                      context,
                      title: "Client Mode",
                      subtitle: "Create & manage projects",
                      active: isClient,
                      onTap: () {
                        state.setRole('client');
                      },
                    ),
                    const Divider(),
                    _modeTile(
                      context,
                      title: "Freelancer Mode",
                      subtitle: "Work on assigned projects",
                      active: !isClient,
                      onTap: () {
                        state.setRole("freelancer");
                      },
                    ),
                    const Divider(),
                    _modeTile(
                      context,
                      title: "Admin Mode",
                      subtitle: "System oversight",
                      active: state.isAdmin,
                      onTap: () {
                        // state.setAdminMode();
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// QUICK ACTIONS
              const Text("Quick Access", style: TextStyle(fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),

              AppCard(
                child: Column(
                  children: [
                    _menuItem(icon: Icons.account_balance_wallet, title: "Wallet", onTap: () {}),
                    _menuItem(icon: Icons.notifications, title: "Notifications", onTap: () {}),
                    _menuItem(icon: Icons.receipt_long, title: "Transactions", onTap: () {}),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// SECURITY
              const Text("Security", style: TextStyle(fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),

              AppCard(
                child: Column(
                  children: [
                    _menuItem(icon: Icons.lock, title: "Change Password", onTap: () {}),
                    _menuItem(icon: Icons.verified_user, title: "KYC Verification", onTap: () {}),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// LOGOUT
              PrimaryButton(text: "Logout", onTap: () {}),
            ],
          ),
        );
      },
    );
  }

  Widget _modeTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool active,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        active ? Icons.check_circle : Icons.circle_outlined,
        color: active ? AppColors.primary : Colors.grey,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  Widget _menuItem({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
      onTap: onTap,
    );
  }
}
