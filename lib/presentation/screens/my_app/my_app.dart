import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/pages/login_signup_screen.dart';
import '../cart/pages/cart_screen.dart';
import '../common/utils/size_config.dart';
import '../dashboard/pages/dashboard_screen.dart';
import '../splash/page/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SConfig.init(context);
    return GetMaterialApp(
      title: 'Medicare+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff478ef8)),
      ),
      initialRoute: "/SplashScreen",
      getPages: [
        GetPage(name: "/SplashScreen", page: () => const SplashScreen()),
        GetPage(name: "/DashboardScreen", page: () => const DashboardScreen()),
        GetPage(name: "/ShoppingCart", page: () => const ShoppingCart()),
        // GetPage(name: "/LoginSignupScreen", page: () => const LoginSignupScreen()),
      ],
    );
  }
}
