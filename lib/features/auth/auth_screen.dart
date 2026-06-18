import 'package:flutter/material.dart';
import 'package:milio/main.dart';
import 'package:milio/repositories/dummy_data.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final _emailController = TextEditingController(text: 'ade@freelancer.com');
  final _passwordController = TextEditingController(text: 'password');

  void _authenticate() {
    // Dummy auth
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login successful!')));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLogin ? 'Welcome Back' : 'Create Account',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 24),
            SwitchListTile(
              title: const Text('I am a Client'),
              value: DummyRepository.isClientMode,
              onChanged: (val) => setState(() => DummyRepository.isClientMode = val),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: _authenticate, child: Text(isLogin ? 'Login' : 'Sign Up')),
            ),
            TextButton(
              onPressed: () => setState(() => isLogin = !isLogin),
              child: Text(isLogin ? "Don't have an account? Sign up" : "Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
