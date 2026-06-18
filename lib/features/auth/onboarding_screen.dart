import 'package:flutter/material.dart';
import 'package:milio/features/home/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Secure Milestone Payments",
      "desc": "Get paid safely as you deliver milestones",
      "image": "💰",
    },
    {"title": "Smart Wallet System", "desc": "Track earnings and withdraw instantly", "image": "👛"},
    {"title": "Grow Your Freelance Business", "desc": "Build trust with verified clients", "image": "🚀"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  final data = _onboardingData[index];
                  return Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(data["image"]!, style: const TextStyle(fontSize: 120)),
                        const SizedBox(height: 40),
                        Text(
                          data["title"]!,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          data["desc"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                    },
                    child: const Text('Skip'),
                  ),
                  Row(
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _currentPage == 2
                        ? () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                          }
                        : () => _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          ),
                    child: Text(_currentPage == 2 ? "Get Started" : "Next"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
