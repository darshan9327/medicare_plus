import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/utils/common_appbar.dart';
import '../../common/utils/size_config.dart';
import '../widgets/secure_payment_widget/payment_amount.dart';
import '../widgets/secure_payment_widget/payment_processing.dart';
import '../widgets/secure_payment_widget/payment_security_info.dart';
import 'success_order_screen.dart';

class SecurePayment extends StatefulWidget {
  final double totalAmount;
  const SecurePayment({super.key, required this.totalAmount});

  @override
  State<SecurePayment> createState() => _SecurePaymentState();
}

class _SecurePaymentState extends State<SecurePayment> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(
        SuccessOrder(
          orderId: "ORD${DateTime.now().millisecondsSinceEpoch}",
          amount: widget.totalAmount,
          paymentStatus: "Completed",
          orderStatus: "Order Placed",
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "Payment"),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.credit_card, size: 80, color: Colors.blueAccent),
              SizedBox(height: SConfig.sHeight * 0.050),

              const Text("Secure Payment", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: SConfig.sHeight * 0.020),
              const Text(
                "You will be redirected to your\nselected payment method",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: SConfig.sHeight * 0.070),
              PaymentAmount(amount: widget.totalAmount),
              SizedBox(height: SConfig.sHeight * 0.060),
              const PaymentProcessing(),
              SizedBox(height: SConfig.sHeight * 0.040),
              const PaymentSecurityInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
