import 'package:flutter/material.dart';
import 'package:milio/features/auth/role_selection_screen.dart';
import 'package:milio/main.dart';
import 'package:milio/providers/app_provider.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            /// LOGO
            const Icon(Icons.lock_outline, size: 80),

            const SizedBox(height: 20),

            /// HEADLINE
            const Text(
              "Secure payments for digital work",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            const Text(
              "Milio holds funds in escrow until work is delivered. No disputes. No unpaid work.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),

            const SizedBox(height: 40),

            /// FEATURES
            _feature(icon: Icons.verified, text: "Milestone-based payments"),
            _feature(icon: Icons.lock, text: "Secure escrow protection"),
            _feature(icon: Icons.trending_up, text: "Transparent project tracking"),

            const Spacer(),

            /// APPLE SIGN IN
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.all(14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.apple, color: Colors.white),
                label: const Text("Continue with Apple", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  _goToApp(context);
                },
              ),
            ),

            const SizedBox(height: 12),

            /// GOOGLE SIGN IN
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.g_mobiledata),
                label: const Text("Continue with Google"),
                onPressed: () {
                  _goToApp(context);
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _goToApp(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    if (appState.role == null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RoleSelectionScreen()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen()));
    }
  }

  Widget _feature({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(children: [Icon(icon, size: 18), const SizedBox(width: 10), Text(text)]),
    );
  }
}
