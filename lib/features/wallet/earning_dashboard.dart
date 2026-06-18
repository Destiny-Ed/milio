import 'package:flutter/material.dart';
import 'package:milio/providers/app_provider.dart';
import 'package:provider/provider.dart';

class EarningsDashboard extends StatelessWidget {
  const EarningsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final user = appState.currentUser;
    final transactions = appState.transactions;

    final thisMonthEarnings = transactions
        .where((t) => t.type == 'credit' && t.date.month == DateTime.now().month)
        .fold(0.0, (sum, t) => sum + t.amount);

    return Scaffold(
      appBar: AppBar(title: const Text('Earnings Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total Earned',
                    '₦${user.totalEarned.toStringAsFixed(0)}',
                    Icons.trending_up,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'This Month',
                    '₦${thisMonthEarnings.toStringAsFixed(0)}',
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Earnings Trend', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const Card(
              child: SizedBox(height: 200, child: Center(child: Text('Chart would go here (fl_chart)'))),
            ),
            const SizedBox(height: 24),
            const Text('Recent Earnings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ...transactions
                .where((t) => t.type == 'credit')
                .map(
                  (t) => ListTile(
                    leading: const Icon(Icons.arrow_downward, color: Colors.green),
                    title: Text(t.description),
                    subtitle: Text(t.date.toString().substring(0, 10)),
                    trailing: Text(
                      '+₦${t.amount.toStringAsFixed(0)}',
                      style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.green),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 14)),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
