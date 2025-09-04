import 'package:flutter/material.dart';

class ProfileOptionTile extends StatelessWidget {
  final String iconEmoji;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ProfileOptionTile({super.key, required this.iconEmoji, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: Colors.grey[100], radius: 25, child: Text(iconEmoji, style: const TextStyle(fontSize: 17))),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }
}
