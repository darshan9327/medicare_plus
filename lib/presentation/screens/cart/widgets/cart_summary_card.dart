import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';
import 'summary_row.dart';


class CartSummaryCard extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double total;

  CartSummaryCard({super.key, required this.subtotal, required this.deliveryFee, required this.tax, required this.total});
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SummaryRow(label: "Subtotal", value: subtotal),
            SummaryRow(label: "Delivery Fee", value: cartController.cartItems.isEmpty ? 0 : deliveryFee),
            SummaryRow(label: "Tax", value: tax),
            const Divider(),
            SummaryRow(label: "Total", value: cartController.cartItems.isEmpty ? 0 : total, bold: true),
          ],
        ),
      ),
    );
  }
}
