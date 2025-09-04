import 'package:flutter/material.dart';

import '../../../common/utils/size_config.dart';
import '../../../common/widgets/common_container.dart';

class OrderSummary extends StatelessWidget {
  final double finalAmount;
  final VoidCallback onPlaceOrder;

  const OrderSummary({super.key, required this.finalAmount, required this.onPlaceOrder});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Total Amount  ₹${finalAmount.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: SConfig.sHeight * 0.040),
          CommonContainer(text: "Place Order", onPressed: onPlaceOrder),
        ],
      ),
    );
  }
}
