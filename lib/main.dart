import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare_plus/presentation/screens/cart/controller/cart_controller.dart';
import 'presentation/screens/my_app/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(CartController(), permanent: true);
  runApp(const MyApp());
}


