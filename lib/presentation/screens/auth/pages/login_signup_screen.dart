import 'package:flutter/material.dart';

import '../../common/utils/size_config.dart';
import '../widgets/login_page.dart';
import '../widgets/sign_up_page.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Icon(Icons.lock, size: 60, color: Colors.orange),
              const SizedBox(height: 20),
              const Text("Welcome Back", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const Text("Sign in to your account", style: TextStyle(color: Colors.grey)),
              SizedBox(height: SConfig.sHeight * 0.030),

              // -------- TabBar ----------
              Container(
                height: 60,
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: const EdgeInsets.all(5),
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.grey.shade300, spreadRadius: 1, blurRadius: 5)],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.black,
                  tabs: const [Tab(text: "Login"), Tab(text: "Signup")],
                  labelStyle: const TextStyle(fontSize: 18),
                ),
              ),

              SizedBox(height: SConfig.sHeight * 0.030),

              // -------- TabBarView ----------
              SizedBox(height: SConfig.sHeight * 0.65, child: TabBarView(controller: _tabController, children: [LoginForm(), SignupForm()])),
            ],
          ),
        ),
      ),
    );
  }
}
