import 'package:flutter/material.dart';
import 'package:milio/providers/app_provider.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final user = appState.currentUser;
    final txns = appState.transactions;

    return Scaffold(
      appBar: AppBar(title: const Text('Wallet')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF00C853), Color(0xFF64DD17)]),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const Text('Available Balance', style: TextStyle(color: Colors.white70, fontSize: 16)),
                  Text(
                    '₦${user.walletBalance.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    'Total Earned: ₦${user.totalEarned.toStringAsFixed(0)}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Add Funds'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_outward),
                    label: const Text('Withdraw'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Recent Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            Expanded(
              child: ListView.builder(
                itemCount: txns.length,
                itemBuilder: (context, index) {
                  final txn = txns[index];
                  return ListTile(
                    leading: Icon(
                      txn.type == 'credit' ? Icons.arrow_downward : Icons.arrow_upward,
                      color: txn.type == 'credit' ? Colors.green : Colors.red,
                    ),
                    title: Text(txn.description),
                    subtitle: Text(txn.date.toString().substring(0, 10)),
                    trailing: Text(
                      '₦${txn.amount.toStringAsFixed(0)}',
                      style: TextStyle(color: txn.type == 'credit' ? Colors.green : Colors.red),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
