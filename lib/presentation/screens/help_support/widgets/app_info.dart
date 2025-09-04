import 'package:flutter/material.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  Widget _buildInfoRow(String title, String value, {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Color(0xFF6B7280))),
          Text(
            value,
            style: TextStyle(
              color: isLink ? const Color(0xFF2563EB) : const Color(0xFF111827),
              fontWeight: FontWeight.w600,
              decoration: isLink ? TextDecoration.underline : null,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("App Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 15),
          _buildInfoRow("Version", "v2.1.0"),
          _buildInfoRow("Last Updated", "15 Mar 2024"),
          _buildInfoRow("Privacy Policy", "View Policy", isLink: true),
          _buildInfoRow("Terms of Service", "View Terms", isLink: true),
          _buildInfoRow("Rate This App", "⭐⭐⭐⭐⭐", isLink: true),
        ],
      ),
    );
  }
}
