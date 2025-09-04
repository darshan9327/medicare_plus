import 'package:flutter/material.dart';

class SConfig {
  static late MediaQueryData _mediaQueryData;
  static late double sWidth;
  static late double sHeight;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    sWidth = _mediaQueryData.size.width;
    sHeight = _mediaQueryData.size.height;
  }
}
