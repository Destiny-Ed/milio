import 'package:milio/core/enums.dart';
import 'package:milio/models/bank_acount_model.dart';
import 'package:milio/models/milestone_model.dart';
import 'package:milio/models/project_model.dart';
import 'package:milio/models/user_model.dart';
import 'package:milio/models/transaction_model.dart';
import 'package:milio/models/withdrawal_model.dart';

class DummyRepository {
  // static User currentUser = User(
  //   uid: 'freelancer_001',
  //   fullName: 'Adekunle Adebayo',
  //   role: UserRole.freelancer,
  //   email: 'ade@freelancer.com',
  //   walletBalance: 245000,
  //   totalEarned: 850000,
  //   pendingWithdrawals: 45000,
  // );

  static bool isClientMode = false; // Toggle for demo

  static User get currentUser => isClientMode
      ? User(
          uid: 'client_001',
          fullName: 'Sarah Johnson',
          role: UserRole.client,
          email: 'sarah@techcorp.com',
          walletBalance: 0.0,
        )
      : User(
          uid: 'freelancer_001',
          fullName: 'Adekunle Adebayo',
          role: UserRole.freelancer,
          email: 'ade@freelancer.com',
          walletBalance: 245000,
          totalEarned: 850000,
          pendingWithdrawals: 45000,
        );

  static List<BankAccount> bankAccounts = [
    BankAccount(
      id: 'b1',
      bankName: 'GTBank',
      accountNumber: '0123456789',
      accountName: 'Adekunle Adebayo',
      isPrimary: true,
    ),
  ];

  static List<Transaction> transactions = [
    Transaction(
      id: 't1',
      userId: "ed",
      type: TransactionType.milestoneRelease,
      amount: 300000,
      description: 'Design Milestone Approved - E-commerce App',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: 't2',
      userId: "dk",
      type: TransactionType.withdrawal,
      amount: 50000,
      description: 'Withdrawal to GTBank',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  static List<Project> myProjects = [
    Project(
      id: 'p1',
      state: ProjectState.inProgress,
      title: 'E-commerce Mobile App',
      clientName: 'TechCorp Ltd',
      freelancerId: 'freelancer_001',
      totalBudget: 1000000,
      status: 'in_progress',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      milestones: [
        Milestone(
          id: 'm1',
          title: 'UI/UX Design',
          percentage: 30,
          amount: 300000,
          status: 'approved',
          approvedAt: DateTime.now().subtract(const Duration(days: 10)),
          state: MilestoneState.approved,
        ),
        Milestone(
          id: 'm2',
          title: 'Backend API Development',
          percentage: 40,
          amount: 400000,
          status: 'submitted',
          state: MilestoneState.submitted,

          submittedAt: DateTime.now().subtract(const Duration(days: 3)),
        ),
        Milestone(
          id: 'm3',
          title: 'Final Delivery & Testing',
          percentage: 30,
          amount: 300000,
          state: MilestoneState.pending,

          status: 'pending',
        ),
      ],
    ),
  ];

  static List<Project> clientProjects = [
    Project(
      id: 'p1',
      title: 'E-commerce Mobile App',
      clientName: 'TechCorp Ltd',
      freelancerId: 'freelancer_001',
      totalBudget: 1000000,
      status: 'in_progress',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      milestones: [
        Milestone(
          id: 'm1',
          title: 'UI/UX Design',
          percentage: 30,
          amount: 300000,
          status: 'approved',
          state: MilestoneState.approved,

          approvedAt: DateTime.now().subtract(const Duration(days: 10)),
        ),
        Milestone(
          id: 'm2',
          title: 'Backend API Development',
          percentage: 40,
          amount: 400000,
          status: 'submitted',
          state: MilestoneState.submitted,

          submissionNote: 'Completed API endpoints, Postman collection attached.',
          submittedAt: DateTime.now().subtract(const Duration(days: 3)),
        ),
        Milestone(
          id: 'm3',
          title: 'Final Delivery & Testing',
          percentage: 30,
          amount: 300000,
          status: 'pending',
          state: MilestoneState.pending,
        ),
      ],
      state: ProjectState.inProgress,
    ),
  ];

  static List<Withdrawal> withdrawals = [
    Withdrawal(
      id: 'w1',
      amount: 45000,
      bankName: 'GTBank',
      accountNumber: '0123456789',
      accountName: 'Adekunle Adebayo',
      status: 'processing',
      requestedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];
}
