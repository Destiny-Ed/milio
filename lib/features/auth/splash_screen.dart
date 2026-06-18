import 'package:flutter/material.dart';
import 'package:milio/features/auth/onboarding_screen.dart';
import 'package:milio/main.dart';
import 'dart:async';

import 'package:milio/providers/app_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _boot();
  }

  void _boot() async {
    await Future.delayed(const Duration(seconds: 2));

    final appState = Provider.of<AppState>(context, listen: false);

    if (!mounted) return;

    if (appState.role != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.lock, size: 80, color: Colors.white),
            SizedBox(height: 12),
            Text(
              "Milio",
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text("Escrow for digital work", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
