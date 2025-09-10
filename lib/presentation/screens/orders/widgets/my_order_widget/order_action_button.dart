import 'package:flutter/material.dart';

class OrderActionButton extends StatelessWidget {
  final String text;
  final Color color;
  final bool isOutlined;
  final VoidCallback? onPressed;

  const OrderActionButton({
    super.key,
    required this.text,
    required this.color,
    this.isOutlined = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: isOutlined ? color : Colors.white,
        backgroundColor: isOutlined ? Colors.white : color,
        side: BorderSide(color: color, width: 1.5),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed ?? () => debugPrint("$text clicked"),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
