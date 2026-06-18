import 'package:flutter/material.dart';
import 'package:milio/repositories/dummy_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = DummyRepository.currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 50, backgroundColor: Colors.green),
            const SizedBox(height: 16),
            Text(user.fullName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(user.email),
            const SizedBox(height: 40),
            ListTile(leading: const Icon(Icons.logout), title: const Text('Logout'), onTap: () {}),
          ],
        ),
      ),
    );
  }
}
