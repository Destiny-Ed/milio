import 'package:flutter/material.dart';
import 'package:milio/core/theme.dart';
import 'package:milio/features/projects/create_project_screen.dart';
import 'package:milio/features/projects/project_details_screen.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/search_field.dart';
import '../../core/widgets/stats_card.dart';
import '../../core/widgets/status_chip.dart';
import '../../core/widgets/empty_state.dart';
import '../../providers/app_provider.dart';
import '../../repositories/dummy_data.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return AppColors.primary;
      case 'completed':
        return AppColors.success;
      case 'pending':
        return AppColors.warning;
      case 'cancelled':
        return AppColors.error;
      default:
        return AppColors.textTertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final projects = DummyRepository.clientProjects;

    return Scaffold(
      backgroundColor: AppColors.background,

      // FAB
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to create project later
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateProjectScreen()));
        },
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "New Project",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Consumer<AppState>(
                builder: (context, appState, _) {
                  return AppCard(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "My Projects",
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              appState.isClientMode ? "Client Mode" : "Freelancer Mode",
                              style: const TextStyle(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                        TextButton.icon(
                          onPressed: () {
                            appState.switchRoleMode();
                          },
                          icon: const Icon(Icons.swap_horiz),
                          label: const Text("Switch"),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: AppSpacing.md),

              /// STATS ROW
              Row(
                children: const [
                  Expanded(
                    child: StatsCard(title: "Active", value: "6"),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: StatsCard(title: "Escrow", value: "₦2.4M"),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.md),

              /// SEARCH
              const SearchField(hint: "Search projects..."),

              const SizedBox(height: AppSpacing.md),

              /// LIST HEADER
              const Text("Recent Projects", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),

              const SizedBox(height: AppSpacing.sm),

              /// PROJECT LIST
              Expanded(
                child: projects.isEmpty
                    ? EmptyState(
                        title: "No Projects Yet",
                        subtitle: "Create your first escrow project to start managing milestones securely.",
                        buttonText: "Create Project",
                        onTap: () {},
                      )
                    : ListView.separated(
                        itemCount: projects.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final project = projects[index];

                          return AppCard(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProjectDetailScreen(
                                      title: project.title,
                                      budget: project.totalBudget,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// TITLE ROW
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          project.title,
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      StatusChip(
                                        label: project.status,
                                        color: _getStatusColor(project.status),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  /// CLIENT / BUDGET
                                  Text(
                                    "₦${project.totalBudget.toStringAsFixed(0)}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  /// PROGRESS BAR
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: LinearProgressIndicator(
                                      value: project.progress ?? 0.5,
                                      minHeight: 6,
                                      backgroundColor: AppColors.border.withOpacity(0.4),
                                      valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  /// FOOTER
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${((project.progress ?? 0.5) * 100).toInt()}% Complete",
                                        style: const TextStyle(fontSize: 12, color: AppColors.textTertiary),
                                      ),
                                      const Text(
                                        "View →",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
