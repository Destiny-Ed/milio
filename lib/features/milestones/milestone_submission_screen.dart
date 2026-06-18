import 'package:flutter/material.dart';
import 'package:milio/repositories/dummy_data.dart';
import '../../models/milestone_model.dart';
import '../../models/project_model.dart';

class MilestoneSubmissionScreen extends StatefulWidget {
  final Project project;
  final Milestone milestone;

  const MilestoneSubmissionScreen({super.key, required this.project, required this.milestone});

  @override
  State<MilestoneSubmissionScreen> createState() => _MilestoneSubmissionScreenState();
}

class _MilestoneSubmissionScreenState extends State<MilestoneSubmissionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  List<String> attachedFiles = []; // Dummy file names
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _notesController.text = widget.milestone.submissionNote ?? '';
  }

  Future<void> _submitMilestone() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    // Simulate API call / Firebase update
    await Future.delayed(const Duration(seconds: 2));

    // Update dummy data
    final milestoneIndex = widget.project.milestones.indexWhere((m) => m.id == widget.milestone.id);
    if (milestoneIndex != -1) {
      final updatedMilestone = Milestone(
        id: widget.milestone.id,
        title: widget.milestone.title,
        percentage: widget.milestone.percentage,
        amount: widget.milestone.amount,
        status: 'submitted',
        submissionNote: _notesController.text,
        submittedAt: DateTime.now(),
      );

      DummyRepository.myProjects.first.milestones[milestoneIndex] = updatedMilestone;
    }

    if (mounted) {
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Milestone submitted successfully! ✅'), backgroundColor: Colors.green),
      );
      Navigator.pop(context, true); // Return success
    }
  }

  void _simulateFileUpload() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Attach Files'),
        content: const Text('In real app, this would open file picker (image, PDF, ZIP, etc.)'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                attachedFiles.add('project_design_v2.fig');
              });
              Navigator.pop(context);
            },
            child: const Text('Attach Design File'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                attachedFiles.add('api_documentation.pdf');
              });
              Navigator.pop(context);
            },
            child: const Text('Attach Document'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Submit ${widget.milestone.title}')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Milestone Info Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.milestone.title, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text(
                        '${widget.milestone.percentage}% • ₦${widget.milestone.amount.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),
                      const Divider(height: 24),
                      Text(
                        'Project: ${widget.project.title}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Submission Notes
              const Text('Submission Notes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _notesController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Describe what you delivered, any challenges, links, etc...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  alignLabelWithHint: true,
                ),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Please provide submission notes' : null,
              ),

              const SizedBox(height: 24),

              // Attachments
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Attachments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  TextButton.icon(
                    onPressed: _simulateFileUpload,
                    icon: const Icon(Icons.attach_file),
                    label: const Text('Add File'),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              if (attachedFiles.isEmpty)
                const Text('No files attached yet', style: TextStyle(color: Colors.grey)),
              ...attachedFiles.map(
                (file) => ListTile(
                  leading: const Icon(Icons.insert_drive_file, color: Colors.blue),
                  title: Text(file),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      setState(() => attachedFiles.remove(file));
                    },
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitMilestone,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Submit Milestone',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                ),
              ),

              const SizedBox(height: 16),
              const Text(
                'Once submitted, the client will review and approve. You will be notified.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}
