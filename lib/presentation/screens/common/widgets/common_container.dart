import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? color1;
  final VoidCallback onPressed;

  const CommonContainer({super.key, required this.text, this.color, this.color1, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: color1 ?? Colors.transparent, width: 1.7),
        backgroundColor: color ?? Color(0xff478ef8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 13),
      ),
      onPressed: onPressed,
      child: Center(child: Text(text, style: TextStyle(color: color1 ?? Colors.white, fontSize: 17, fontWeight: FontWeight.bold))),
    );
  }
}
