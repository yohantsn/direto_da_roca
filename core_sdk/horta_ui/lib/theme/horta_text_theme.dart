import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HortaTextTheme extends TextTheme {
  HortaTextTheme.light()
    : super(
        displayLarge: GoogleFonts.playfairDisplay(
          color: Color(0xFF4A2C2A),
          fontWeight: .bold,
          height: 1.5,
        ),
        headlineMedium: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: .w500,
          color: Colors.black87,
        ),
        bodyMedium: GoogleFonts.montserrat(fontSize: 16, color: Colors.black87),
      );
}
