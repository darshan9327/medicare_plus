import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/utils/size_config.dart';
import '../splash/page/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Medicare+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff478ef8)),
      ),
      home: Builder(
        builder: (context) {
          SConfig.init(context);
          return const SplashScreen();
        },
      ),
    );
  }
}