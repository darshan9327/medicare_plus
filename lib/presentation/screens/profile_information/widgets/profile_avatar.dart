import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String initials;
  const ProfileAvatar({super.key, required this.initials});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: const Color(0xFF478ef8),
            child: Text(initials, style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black26)],
              ),
              child: const Icon(Icons.camera_alt, color: Color(0xff478ef8), size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
