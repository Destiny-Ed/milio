import 'package:flutter/material.dart';
import 'package:milio/features/projects/client_project_details_screen.dart';
import 'package:milio/providers/app_provider.dart';
import 'package:milio/repositories/dummy_data.dart';
import 'package:provider/provider.dart';

class ClientProjectsScreen extends StatelessWidget {
  const ClientProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Projects'),
        actions: [
          // TextButton(
          //   onPressed: () {
          //     DummyRepository.isClientMode = !DummyRepository.isClientMode;
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //         content: Text('Switched to ${DummyRepository.isClientMode ? "Client" : "Freelancer"} Mode'),
          //       ),
          //     );
          //     Navigator.pushReplacementNamed(context, '/'); // Refresh home
          //   },
          //   child: Text(DummyRepository.isClientMode ? 'Switch to Freelancer' : 'Switch to Client'),
          // ),
          Consumer<AppState>(
            builder: (context, appState, child) {
              return TextButton(
                onPressed: () {
                  appState.switchRole();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Switched to ${appState.isClientMode ? "Client" : "Freelancer"} Mode'),
                    ),
                  );
                },
                child: Text(appState.isClientMode ? 'Switch to Freelancer' : 'Switch to Client'),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: DummyRepository.clientProjects.length,
        itemBuilder: (context, index) {
          final project = DummyRepository.clientProjects[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(project.title),
              subtitle: Text('₦${project.totalBudget.toStringAsFixed(0)}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ClientProjectDetailScreen(project: project)),
              ),
            ),
          );
        },
      ),
    );
  }
}
