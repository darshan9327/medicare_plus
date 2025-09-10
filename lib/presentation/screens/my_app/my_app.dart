import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare_plus/presentation/screens/common/utils/size_config.dart';

import '../cart/pages/cart_screen.dart';
import '../dashboard/pages/dashboard_screen.dart';
import '../orders/pages/order_detail_screen.dart';
import '../splash/page/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

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
        GetPage(name: "/GetOrderById", page: () => const OrderDetailsScreen(orderId: 22)),
      ],
    );
  }
}
