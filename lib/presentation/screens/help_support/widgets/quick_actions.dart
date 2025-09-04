import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  final VoidCallback onLiveChat;
  const QuickActions({super.key, required this.onLiveChat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Quick Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: _buildAction("💬", "Live Chat", onLiveChat)),
              const SizedBox(width: 15),
              Expanded(child: _buildAction("📞", "Call Us", () {})),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAction(String emoji, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() =>
      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)]);
}
