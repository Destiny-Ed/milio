import 'package:flutter/material.dart';
import 'package:milio/core/theme.dart';
import 'package:milio/core/widgets/buttons.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/app_card.dart';
import '../../providers/app_provider.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) {
        final isClient = state.isClientMode;

        return Scaffold(
          appBar: AppBar(title: const Text("Wallet")),

          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              /// BALANCE CARD
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Total Balance", style: TextStyle(color: AppColors.textSecondary)),
                    const SizedBox(height: 8),
                    const Text("₦850,000", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(child: _infoBox("Locked", "₦300,000", AppColors.warning)),
                        const SizedBox(width: 12),
                        Expanded(child: _infoBox("Available", "₦550,000", AppColors.success)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// ACTIONS (FREELANCER ONLY)
              if (!isClient) ...[
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(text: "Withdraw", onTap: () {}),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],

              /// TRANSACTIONS
              const Text("Transactions", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

              const SizedBox(height: 12),

              ...List.generate(5, (index) {
                return AppCard(
                  child: ListTile(
                    leading: Icon(
                      index % 2 == 0 ? Icons.arrow_downward : Icons.arrow_upward,
                      color: index % 2 == 0 ? AppColors.success : AppColors.warning,
                    ),
                    title: Text(index % 2 == 0 ? "Milestone Payment" : "Withdrawal"),
                    subtitle: const Text("Today", style: TextStyle(color: AppColors.textSecondary)),
                    trailing: Text(
                      index % 2 == 0 ? "+₦120,000" : "-₦50,000",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: index % 2 == 0 ? AppColors.success : AppColors.error,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _infoBox(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}
