import 'package:flutter/material.dart';
import 'package:milio/repositories/dummy_data.dart';

class WithdrawalsScreen extends StatelessWidget {
  const WithdrawalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final withdrawals = DummyRepository.withdrawals;
    final banks = DummyRepository.bankAccounts;

    return Scaffold(
      appBar: AppBar(title: const Text('Withdrawals')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton.icon(
              onPressed: () {
                // Show form for new withdrawal
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('New Withdrawal Request Form - Demo')));
              },
              icon: const Icon(Icons.payment),
              label: const Text('New Withdrawal Request'),
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 56)),
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: withdrawals.length,
              itemBuilder: (context, index) {
                final w = withdrawals[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: ListTile(
                    title: Text('₦${w.amount.toStringAsFixed(0)}'),
                    subtitle: Text('${w.bankName} • ${w.accountNumber}'),
                    trailing: Chip(label: Text(w.status.toUpperCase())),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
