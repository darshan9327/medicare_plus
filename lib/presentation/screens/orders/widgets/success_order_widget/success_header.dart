import 'package:flutter/material.dart';

class SuccessHeader extends StatelessWidget {
  const SuccessHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text("✅", style: TextStyle(fontSize: 70)),
        SizedBox(height: 20),
        Text("Order Placed\nSuccessfully!", textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Text("Thank you for your order", style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
