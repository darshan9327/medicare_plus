import 'package:flutter/material.dart';

import '../../../common/utils/size_config.dart';

class OrderDetailsCard extends StatelessWidget {
  final String orderId;
  final double amount;
  final String paymentStatus;
  final String orderStatus;

  const OrderDetailsCard({super.key, required this.orderId, required this.amount, required this.paymentStatus, required this.orderStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Order Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),

          _buildRow("Order ID:", "#$orderId"),
          SizedBox(height: SConfig.sHeight * 0.010),

          _buildRow("Total Amount:", "₹${amount.toStringAsFixed(2)}"),
          SizedBox(height: SConfig.sHeight * 0.010),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Payment:"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: paymentStatus == "Completed" ? Colors.green[100] : Colors.orange[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(paymentStatus, style: TextStyle(color: paymentStatus == "Completed" ? Colors.green : Colors.orange)),
              ),
            ],
          ),
          SizedBox(height: SConfig.sHeight * 0.010),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Status:"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(20)),
                child: Text(orderStatus, style: const TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label), Text(value, style: const TextStyle(fontWeight: FontWeight.w600))],
    );
  }
}
