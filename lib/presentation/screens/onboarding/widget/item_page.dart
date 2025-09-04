import 'package:flutter/material.dart';

class OnboardingItem extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;

  const OnboardingItem({super.key, required this.emoji, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 100)),
        const SizedBox(height: 40),
        Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        const SizedBox(height: 20),
        Text(subtitle, style: const TextStyle(fontSize: 16, color: Colors.grey), textAlign: TextAlign.center),
      ],
    );
  }
}
