import 'package:flutter/material.dart';
import 'package:milio/features/projects/project_details_screen.dart';
import 'package:milio/repositories/dummy_data.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Projects')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: DummyRepository.myProjects.length,
        itemBuilder: (context, index) {
          final project = DummyRepository.myProjects[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(project.title),
              subtitle: Text('₦${project.totalBudget.toStringAsFixed(0)} • ${project.clientName}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProjectDetailScreen(project: project)),
              ),
            ),
          );
        },
      ),
    );
  }
}
