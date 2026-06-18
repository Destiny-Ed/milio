// import 'package:flutter/material.dart';
// import 'package:milio/providers/app_provider.dart';
// import 'package:milio/repositories/dummy_data.dart';
// import 'package:provider/provider.dart';
// import '../../models/project_model.dart';
// import '../../models/milestone_model.dart';
// import '../../models/wallet_transaction_model.dart';

// class MilestoneApprovalScreen extends StatefulWidget {
//   final Project project;
//   final Milestone milestone;

//   const MilestoneApprovalScreen({super.key, required this.project, required this.milestone});

//   @override
//   State<MilestoneApprovalScreen> createState() => _MilestoneApprovalScreenState();
// }

// class _MilestoneApprovalScreenState extends State<MilestoneApprovalScreen> {
//   bool _isApproving = false;
//   String? _rejectionReason;

//   Future<void> _approveMilestone() async {
//     setState(() => _isApproving = true);

//     await Future.delayed(const Duration(seconds: 1));

//     // Update milestone
//     final projectIndex = DummyRepository.clientProjects.indexWhere((p) => p.id == widget.project.id);
//     if (projectIndex != -1) {
//       final milestoneIndex = DummyRepository.clientProjects[projectIndex].milestones.indexWhere(
//         (m) => m.id == widget.milestone.id,
//       );

//       if (milestoneIndex != -1) {
//         final approvedMilestone = Milestone(
//           id: widget.milestone.id,
//           title: widget.milestone.title,
//           percentage: widget.milestone.percentage,
//           amount: widget.milestone.amount,
//           status: 'approved',
//           submissionNote: widget.milestone.submissionNote,
//           submittedAt: widget.milestone.submittedAt,
//           approvedAt: DateTime.now(),
//         );

//         DummyRepository.clientProjects[projectIndex].milestones[milestoneIndex] = approvedMilestone;

//         // Simulate wallet credit for freelancer
//         // final freelancer = DummyRepository.currentUser; // In real app, fetch by freelancerId
//         // if (freelancer.role == UserRole.freelancer) {
//         //   // Update balance
//         //   // For demo, we just log transaction
//         //   DummyRepository.transactions.insert(
//         //     0,
//         //     WalletTransaction(
//         //       id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
//         //       type: 'credit',
//         //       amount: widget.milestone.amount,
//         //       description: '${widget.milestone.title} Approved - ${widget.project.title}',
//         //       date: DateTime.now(),
//         //     ),
//         //   );
//         // Inside _approveMilestone() after updating milestone
//         final appState = Provider.of<AppState>(context, listen: false);
//         appState.addTransaction(
//           WalletTransaction(
//             id: 'txn_${DateTime.now().millisecondsSinceEpoch}',
//             type: 'credit',
//             amount: widget.milestone.amount,
//             description: '${widget.milestone.title} Approved - ${widget.project.title}',
//             date: DateTime.now(),
//           ),
//         );

//         // In real implementation: update freelancer wallet via repository
//         // }
//       }
//     }

//     if (mounted) {
//       setState(() => _isApproving = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Milestone Approved Successfully! 🎉 Wallet credited.'),
//           backgroundColor: Colors.green,
//         ),
//       );
//       Navigator.pop(context, true);
//     }
//   }

//   void _rejectMilestone() {
//     if (_rejectionReason == null || _rejectionReason!.trim().isEmpty) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Please provide a rejection reason')));
//       return;
//     }

//     // Similar logic for rejection...
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text('Milestone rejected: $_rejectionReason')));
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Review Milestone')),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(widget.milestone.title, style: Theme.of(context).textTheme.headlineSmall),
//                     const SizedBox(height: 12),
//                     Text(
//                       '${widget.milestone.percentage}% • ₦${widget.milestone.amount.toStringAsFixed(0)}',
//                       style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
//                     ),
//                     const Divider(height: 32),
//                     Text(
//                       'Submitted by: Adekunle Adebayo',
//                       style: const TextStyle(fontWeight: FontWeight.w500),
//                     ),
//                     if (widget.milestone.submittedAt != null)
//                       Text('Submitted: ${widget.milestone.submittedAt!.toString().substring(0, 10)}'),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 24),
//             const Text('Submission Notes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Text(widget.milestone.submissionNote ?? 'No notes provided.'),
//               ),
//             ),

//             const SizedBox(height: 24),
//             const Text('Attachments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//             const Card(
//               child: ListTile(
//                 leading: Icon(Icons.insert_drive_file),
//                 title: Text('project_backend.zip'),
//                 subtitle: Text('2.4 MB'),
//               ),
//             ),

//             const SizedBox(height: 40),

//             // Action Buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: _isApproving ? null : () => _showRejectionDialog(),
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: Colors.red,
//                       side: const BorderSide(color: Colors.red),
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                     ),
//                     child: const Text('Reject'),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: _isApproving ? null : _approveMilestone,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                     ),
//                     child: _isApproving
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                             'Approve & Release Payment',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showRejectionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Reject Milestone'),
//         content: TextField(
//           onChanged: (value) => _rejectionReason = value,
//           decoration: const InputDecoration(hintText: 'Reason for rejection...'),
//           maxLines: 3,
//         ),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _rejectMilestone();
//             },
//             child: const Text('Reject', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }
// }
