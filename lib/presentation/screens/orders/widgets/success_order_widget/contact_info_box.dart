import 'package:flutter/material.dart';

class ContactInfoBox extends StatelessWidget {
  const ContactInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        boxShadow: const [BoxShadow(color: Color(0xff478ef8), offset: Offset(-4, 0))],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text("📱 We will contact you via WhatsApp/Email for delivery confirmation", style: TextStyle(color: Colors.blue)),
    );
  }
}
