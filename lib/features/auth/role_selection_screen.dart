import 'package:flutter/material.dart';
import 'package:milio/main.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "How will you use Milio?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            const Text(
              "Choose your role to personalize your experience",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 40),

            /// CLIENT CARD
            _roleCard(
              title: "Client",
              subtitle: "Hire freelancers & fund projects",
              icon: Icons.business,
              onTap: () {
                appState.setRole("client");
                _goToApp(context);
              },
            ),

            const SizedBox(height: 16),

            /// FREELANCER CARD
            _roleCard(
              title: "Freelancer",
              subtitle: "Work on projects & get paid securely",
              icon: Icons.work,
              onTap: () {
                appState.setRole("freelancer");
                _goToApp(context);
              },
            ),

            const SizedBox(height: 16),

            /// ADMIN (optional hidden later)
            _roleCard(
              title: "Admin",
              subtitle: "Platform oversight",
              icon: Icons.shield,
              onTap: () {
                appState.setRole("admin");
                _goToApp(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _goToApp(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen()));
  }

  Widget _roleCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14),
          ],
        ),
      ),
    );
  }
}
