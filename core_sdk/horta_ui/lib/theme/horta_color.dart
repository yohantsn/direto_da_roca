import 'package:flutter/material.dart';

class HortaColor extends ColorScheme {
  HortaColor.light() : super.light();

  @override
  Color get primary => Color(0xFF8B4513);

  @override
  Color get onPrimary => Color(0xFFFFFFFF);

  @override
  Color get secondary => Color(0xFF2E7D32);

  @override
  Color get surface => Color(0xFFFDF5E6);

  @override
  final Color outline = Color(0xFFD2B48C);
}
