import 'dart:ui';

import 'package:flutter/material.dart';

class MyColors{
  static const Color purpleColorCode=const Color(0XFFA64AC9);
  static const Color greenColorCode = const Color(0xFF39B54A);
  static const Color blueColorCode = const Color(0xFF2196F3);
  static const Color orangeColorCode= const Color(0xFFFE6E28);
  static const Color orangeLightColorCode = const Color(0xFFFF8741);
//  static const Color yellowGradient = const Color(0xFFFFFFFF);FCB832-FFE302
  static const Color white = const Color(0xFFFFFFFF);

//  static const Color myPrimaryColor=const Color(0XFFBA68C8);

  static const MaterialColor  red=const MaterialColor(
      0XFFFF0000,
      const<int,Color>{
        50: Color(0xFFFFEBEE),
        100: Color(0xFFFFCDD2),
        200: Color(0xFFEF9A9A),
        300: Color(0xFFE57373),
        400: Color(0xFFEF5350),
        600: Color(0xFFE53935),
        700: Color(0xFFD32F2F),
        800: Color(0xFFC62828),
        900: Color(0xFFB71C1C),

      }
  );

  static const MaterialColor  grey=const MaterialColor(
      0XFFFF0000,
      const<int,Color>{
        50: Color(0xFFFAFAFA),
        100: Color(0xFFF5F5F5),
        200: Color(0xFFEEEEEE),
        300: Color(0xFFE0E0E0),
        350: Color(0xFFD6D6D6), // only for raised button while pressed in light theme
        400: Color(0xFFBDBDBD),
        600: Color(0xFF757575),
        700: Color(0xFF616161),
        800: Color(0xFF424242),
        850: Color(0xFF303030), // only for background color in dark theme
        900: Color(0xFF212121),

      }
  );

}