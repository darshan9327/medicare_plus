import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color backgroundColor;
  final Color titleColor;
  final bool leading;

  const CommonAppBar({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle = false,
    this.backgroundColor = const Color(0xff478ef8),
    this.titleColor = Colors.white,
    this.leading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      elevation: 0,
      actions: actions,
      leading: leading ? InkWell(onTap: () => Get.back(), child: Icon(Icons.arrow_back, color: Colors.white)) : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
