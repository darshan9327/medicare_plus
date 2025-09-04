import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../auth/pages/login_signup_screen.dart';
import '../../dashboard/pages/dashboard_screen.dart';
import '../widget/item_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  final List<Map<String, String>> onboardingData = [
    {"emoji": "🚚", "title": "Fast Delivery", "subtitle": "Get your medicines delivered to your doorstep in just a few hours."},
    {"emoji": "💊", "title": "Genuine Medicine", "subtitle": "We provide only 100% genuine and verified medicines."},
    {"emoji": "⏰", "title": "24 x 7 Available", "subtitle": "Order anytime, we’re available around the clock."},
  ];

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isOnboarded', true);

    final isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

    if (isLoggedIn) {
      Get.offAll(() => const DashboardScreen());
    } else {
      Get.offAll(() => const LoginSignupScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    isLastPage = index == onboardingData.length - 1;
                  });
                },
                itemBuilder: (context, index) {
                  final data = onboardingData[index];
                  return OnboardingItem(
                    emoji: data["emoji"]!,
                    title: data["title"]!,
                    subtitle: data["subtitle"]!,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SmoothPageIndicator(
              controller: _controller,
              count: onboardingData.length,
              effect: const WormEffect(
                activeDotColor: Colors.blue,
                dotHeight: 10,
                dotWidth: 10,
                type: WormType.thin,
                dotColor: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (isLastPage) {
                  _finishOnboarding();
                } else {
                  _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
                }
              },
              child: Text(isLastPage ? "Get Started" : "Next"),
            ),
            TextButton(
              onPressed: _finishOnboarding,
              child: const Text("Skip"),
            ),
          ],
        ),
      ),
    );
  }
}
