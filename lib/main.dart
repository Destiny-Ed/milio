import 'package:flutter/material.dart';
import 'package:milio/core/theme.dart';
import 'package:milio/features/profile/profile_screen.dart';
import 'package:milio/features/projects/project_screen.dart';
import 'package:milio/features/withdrawals/withdrawal_screen.dart';
import 'package:milio/providers/app_provider.dart';
import 'features/home/home_screen.dart';
import 'features/wallet/wallet_screen.dart';
import 'package:provider/provider.dart';
import 'features/auth/onboarding_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => AppState(), child: const MilioApp()));
}

class MilioApp extends StatelessWidget {
  const MilioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Milio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const OnboardingScreen(),
    );
  }
}

// Bottom Navigation
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ProjectsScreen(),
    const WalletScreen(),
    const WithdrawalsScreen(),
    const ProfileScreen(), // You can create this
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.work), label: 'Projects'),
          NavigationDestination(icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
          NavigationDestination(icon: Icon(Icons.payment), label: 'Withdraw'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
