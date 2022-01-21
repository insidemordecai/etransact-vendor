import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor kTeal = MaterialColor(
    0xff009bad, // 0% - color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff008c9c), //10%
      100: Color(0xff007c8a), //20%
      200: Color(0xff006d79), //30%
      300: Color(0xff005d68), //40%
      400: Color(0xff004e57), //50%
      500: Color(0xff003e45), //60%
      600: Color(0xff002e34), //70%
      700: Color(0xff001f23), //80%
      800: Color(0xff000f11), //90%
      900: Color(0xff000000), //100%
    },
  );
}
