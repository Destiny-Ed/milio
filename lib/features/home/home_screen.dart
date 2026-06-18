import 'package:flutter/material.dart';
import 'package:milio/repositories/dummy_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = DummyRepository.currentUser;
    final activeProject = DummyRepository.myProjects.first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Milio'),
        actions: [IconButton(icon: const Icon(Icons.notifications), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back, ${user.fullName.split(' ').first}! 👋',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),

            // Balance Quick View
            Card(
              child: ListTile(
                leading: const Icon(Icons.account_balance_wallet, size: 40, color: Colors.green),
                title: const Text('Wallet Balance'),
                subtitle: Text(
                  '₦${user.walletBalance.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => Navigator.pushNamed(context, '/wallet'), // Use GoRouter in real app
              ),
            ),

            const SizedBox(height: 24),
            const Text('Active Projects', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            Card(
              child: ListTile(
                title: Text(activeProject.title),
                subtitle: Text(
                  '${activeProject.milestones.where((m) => m.status == "approved").length}/${activeProject.milestones.length} Milestones Approved',
                ),
                trailing: Chip(
                  label: Text(activeProject.status.toUpperCase(), style: const TextStyle(fontSize: 12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
