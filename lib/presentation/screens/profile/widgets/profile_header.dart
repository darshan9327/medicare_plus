import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String phone;

  const ProfileHeader({super.key, required this.name, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(radius: 45, backgroundColor: Colors.blue[100], child: const Text("👤", style: TextStyle(color: Colors.purple, fontSize: 35))),
        const SizedBox(height: 15),
        Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Text(phone, style: const TextStyle(color: Colors.grey, fontSize: 16)),
      ],
    );
  }
}
