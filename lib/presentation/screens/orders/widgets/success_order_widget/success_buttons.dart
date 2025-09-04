import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/common_container.dart';
import '../../../dashboard/pages/dashboard_screen.dart';
import '../../pages/my_orders_screen.dart';

class SuccessButtons extends StatelessWidget {
  const SuccessButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonContainer(
          text: "Track Order",
          onPressed: () {
            Get.to(const MyOrders());
          },
        ),
        const SizedBox(height: 20),
        CommonContainer(
          text: "Continue Shopping",
          color: Colors.white,
          color1: const Color(0xff478ef8),
          onPressed: () {
            Get.offAll(const DashboardScreen());
          },
        ),
      ],
    );
  }
}
