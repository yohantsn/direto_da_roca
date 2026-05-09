import 'package:flutter/material.dart';

class HortaColor extends ColorScheme {
  HortaColor.light() : super.light();

  @override
  Color get primary => Color(0xFF4E342E);

  @override
  Color get onPrimary => Color(0xFFFFFFFF);

  @override
  Color get secondary => Color(0xFF386641);

  @override
  Color get surface => Color(0xFFF2E8CF);

  @override
  final Color outline = Color(0xFF4E342E);

  @override
  Color get tertiary => Color(0xFFBC4749);
}
