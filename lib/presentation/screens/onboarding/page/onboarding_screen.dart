import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../auth/pages/login_signup_screen.dart';
import '../../common/utils/size_config.dart';
import '../../common/widgets/common_container.dart';
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
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: SConfig.sHeight * 0.500,
              width: SConfig.sWidth,
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
                  return OnboardingItem(emoji: data["emoji"]!, title: data["title"]!, subtitle: data["subtitle"]!);
                },
              ),
            ),
            SizedBox(height: SConfig.sHeight * 0.020),
            SmoothPageIndicator(
              controller: _controller,
              count: onboardingData.length,
              effect: const WormEffect(activeDotColor: Colors.blue, dotHeight: 10, dotWidth: 10, type: WormType.thin, dotColor: Colors.grey),
              onDotClicked: (index) {
                _controller.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.ease);
              },
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                CommonContainer(
                  onPressed: () {
                    if (isLastPage) {
                      _finishOnboarding();
                    } else {
                      _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
                    }
                  },
                  text: isLastPage ? "Get Started" : "Next",
                ),
                SizedBox(height: SConfig.sHeight * 0.030),
                CommonContainer(color: Colors.grey.shade100, color1: Colors.grey.shade500, onPressed: _finishOnboarding, text: "Skip"),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
