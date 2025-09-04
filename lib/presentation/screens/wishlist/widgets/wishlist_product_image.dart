import 'package:flutter/material.dart';

class WishlistProductImage extends StatelessWidget {
  final String emoji;

  const WishlistProductImage({super.key, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Center(child: Text(emoji, style: const TextStyle(fontSize: 35))),
    );
  }
}
