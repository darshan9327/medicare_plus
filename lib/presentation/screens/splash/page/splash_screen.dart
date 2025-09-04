import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/pages/login_signup_screen.dart';
import '../../common/utils/size_config.dart';
import '../../dashboard/pages/dashboard_screen.dart';
import '../../onboarding/page/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkNavigation();
  }

  Future<void> _checkNavigation() async {
    final prefs = await SharedPreferences.getInstance();

    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final bool isOnboarded = prefs.getBool('isOnboarded') ?? false;

    await Future.delayed(const Duration(seconds: 3));

    if (!isOnboarded) {
      Get.offAll(() => const OnboardingScreen());
    } else if (!isLoggedIn) {
      Get.offAll(() => const LoginSignupScreen());
    } else {
      Get.offAll(() => const DashboardScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    SConfig.init(context);

    return Scaffold(
      backgroundColor: const Color(0xff478ef8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(30),
              child: Image.asset("assets/images/Capsules.png", height: 80),
            ),
            SizedBox(height: SConfig.sHeight * 0.05),
            const Text(
              "MediCare+",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: SConfig.sHeight * 0.04),
            const Text(
              "Your Health, Our Priority",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            SizedBox(height: SConfig.sHeight * 0.05),
            SizedBox(
              width: SConfig.sWidth < 600
                  ? SConfig.sWidth * 0.15
                  : SConfig.sWidth * 0.05,
              child: LinearProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.white24,
                minHeight: 5,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
