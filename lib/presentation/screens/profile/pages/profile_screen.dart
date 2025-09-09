import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicare_plus/presentation/screens/orders/pages/my_orders_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/session_manager.dart';
import '../../addresses/pages/my_address_screen.dart';
import '../../auth/pages/login_signup_screen.dart';
import '../../common/utils/size_config.dart';
import '../../common/widgets/common_container.dart';
import '../../help_support/pages/help_support_screen.dart';
import '../../notification/pages/notification_screen.dart';
import '../../prescription/pages/my_prescription_screen.dart';
import '../../profile_information/page/profile_information_screen.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_options_list.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const ProfileHeader(name: "John Doe", phone: "+91 98765 43210"),
              const SizedBox(height: 30),
              ProfileOptionsList(
                onPersonalInfo: () => Get.to(ProfileInformation()),
                onAddresses: () => Get.to(MyAddressesScreen()),
                onOrders: () => Get.to(MyOrders()),
                onPrescriptions: () => Get.to(MyPrescriptionsScreen()),
                onNotifications: () => Get.to(NotificationsPage()),
                onHelpSupport: () => Get.to(HelpSupportScreen()),
              ),
              SizedBox(height: SConfig.sHeight * 0.030),
              CommonContainer(
                text: "Logout",
                color: Colors.white,
                color1: Colors.red,
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                  await SessionManager.clearSessionId();
                  Get.offAll(LoginSignupScreen);

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
