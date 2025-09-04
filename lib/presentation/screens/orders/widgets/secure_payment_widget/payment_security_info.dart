import 'package:flutter/material.dart';

class PaymentSecurityInfo extends StatelessWidget {
  const PaymentSecurityInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: const [
          Icon(Icons.lock, color: Colors.green),
          SizedBox(width: 8),
          Expanded(child: Text("Your payment is secured with 256-bit SSL encryption", style: TextStyle(color: Colors.green))),
        ],
      ),
    );
  }
}
