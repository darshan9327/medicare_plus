import 'package:flutter/material.dart';

import '../../common/utils/common_appbar.dart';
import '../../common/utils/size_config.dart';
import '../widgets/success_order_widget/contact_info_box.dart';
import '../widgets/success_order_widget/order_details_card.dart';
import '../widgets/success_order_widget/success_buttons.dart';
import '../widgets/success_order_widget/success_header.dart';

class SuccessOrder extends StatefulWidget {
  final String orderId;
  final double amount;
  final String paymentStatus;
  final String orderStatus;

  const SuccessOrder({super.key, required this.orderId, required this.amount, required this.paymentStatus, required this.orderStatus});

  @override
  State<SuccessOrder> createState() => _SuccessOrderState();
}

class _SuccessOrderState extends State<SuccessOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: "Order Confirmed", leading: false),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SuccessHeader(),
                    SizedBox(height: SConfig.sHeight * 0.030),
                    OrderDetailsCard(
                      orderId: widget.orderId,
                      amount: widget.amount,
                      paymentStatus: widget.paymentStatus,
                      orderStatus: widget.orderStatus,
                    ),
                    SizedBox(height: SConfig.sHeight * 0.030),
                    const ContactInfoBox(),
                    SizedBox(height: SConfig.sHeight * 0.035),
                    SuccessButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
