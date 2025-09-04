import 'package:flutter/material.dart';

class PaymentAmount extends StatelessWidget {
  final double amount;
  const PaymentAmount({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("₹${amount.toStringAsFixed(2)}", style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        const Text("Order Total", style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
