import 'package:flutter/material.dart';
import 'package:horta_ui/theme/horta_color.dart';
import 'package:horta_ui/theme/horta_text_theme.dart';

class HortaTheme {
  static ThemeData get light {
    return ThemeData(
      colorScheme: HortaColor.light(),
      textTheme: HortaTextTheme.light(),
    );
  }
}
