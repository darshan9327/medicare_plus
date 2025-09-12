import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/order_models/create_order.dart';
import '../../common/utils/common_appbar.dart';
import '../../common/utils/size_config.dart';
import '../widgets/secure_payment_widget/payment_amount.dart';
import '../widgets/secure_payment_widget/payment_processing.dart';
import '../widgets/secure_payment_widget/payment_security_info.dart';
import 'success_order_screen.dart';

class SecurePayment extends StatefulWidget {
  final Order order;
  final double totalAmount;
  final String orderStatus;
  final VoidCallback? onPaymentComplete;

  const SecurePayment({
    super.key,
    required this.order,
    required this.totalAmount,
    this.orderStatus = "Confirmed",
    this.onPaymentComplete,
  });

  @override
  State<SecurePayment> createState() => _SecurePaymentState();
}

class _SecurePaymentState extends State<SecurePayment> {
  late double totalAmount;

  @override
  void initState() {
    super.initState();
    totalAmount = widget.totalAmount;

    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(
        SuccessOrder(
          orderId: "ORD${widget.order.id}",
          amount: totalAmount,
          paymentStatus: widget.order.paymentStatus,
          orderStatus: widget.orderStatus,
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
              const Text(
                "Secure Payment",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: SConfig.sHeight * 0.020),
              const Text(
                "You will be redirected to your\nselected payment method",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: SConfig.sHeight * 0.070),
              PaymentAmount(amount: totalAmount),
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
