import 'package:flutter/material.dart';
import 'package:milio/features/milestones/milestone_submission_screen.dart';
import 'package:milio/models/project_model.dart';

class ProjectDetailScreen extends StatefulWidget {
  final Project project;
  const ProjectDetailScreen({super.key, required this.project});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.project.title)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Total Budget: ₦${widget.project.totalBudget.toStringAsFixed(0)}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text('Milestones', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ...widget.project.milestones.map(
            (milestone) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(milestone.title),
                subtitle: Text('${milestone.percentage}% • ₦${milestone.amount.toStringAsFixed(0)}'),
                trailing: Chip(
                  label: Text(milestone.status.toUpperCase()),
                  backgroundColor: milestone.status == 'approved' ? Colors.green[100] : Colors.orange[100],
                ),
                onTap: () {
                  if (milestone.status == 'pending' || milestone.status == 'submitted') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            MilestoneSubmissionScreen(project: widget.project, milestone: milestone),
                      ),
                    ).then((success) {
                      if (success == true) {
                        setState(() {}); // Refresh UI
                      }
                    });
                  } else if (milestone.status == 'approved') {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('This milestone has already been approved')));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
