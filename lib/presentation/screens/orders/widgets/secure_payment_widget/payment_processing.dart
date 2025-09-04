import 'package:flutter/material.dart';

class PaymentProcessing extends StatelessWidget {
  const PaymentProcessing({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.autorenew, color: Colors.blue),
        SizedBox(width: 8),
        Text("Processing payment...", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
