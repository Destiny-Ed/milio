import 'package:flutter/material.dart';
import 'package:milio/features/milestones/milestone_approval_screen.dart';
import 'package:milio/models/project_model.dart';

class ClientProjectDetailScreen extends StatefulWidget {
  final Project project;
  const ClientProjectDetailScreen({super.key, required this.project});

  @override
  State<ClientProjectDetailScreen> createState() => _ClientProjectDetailScreenState();
}

class _ClientProjectDetailScreenState extends State<ClientProjectDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.project.title)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ...widget.project.milestones.map(
            (milestone) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(milestone.title),
                subtitle: Text('${milestone.percentage}% • ₦${milestone.amount.toStringAsFixed(0)}'),
                trailing: Chip(
                  label: Text(milestone.status.toUpperCase()),
                  backgroundColor: _getStatusColor(milestone.status),
                ),
                onTap: milestone.status == 'submitted'
                    ? () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              MilestoneApprovalScreen(project: widget.project, milestone: milestone),
                        ),
                      ).then((_) => setState(() {}))
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'approved':
        return Colors.green[100]!;
      case 'submitted':
        return Colors.orange[100]!;
      default:
        return Colors.grey[100]!;
    }
  }
}
