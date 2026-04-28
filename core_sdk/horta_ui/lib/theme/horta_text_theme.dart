import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HortaTextTheme extends TextTheme {
  HortaTextTheme.light()
    : super(
        headlineLarge: GoogleFonts.epilogue(
          color: Colors.black87,
          fontSize: 24,
          fontWeight: .w800,
          height: 1.5,
        ),
        headlineSmall: GoogleFonts.epilogue(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: .w800,
          height: 1.5,
        ),
        bodySmall: GoogleFonts.epilogue(
          color: Color(0xFF4E342E),
          fontSize: 14,
          fontWeight: .w500,
          height: 1.5,
        ),
        bodyLarge: GoogleFonts.epilogue(
          fontSize: 16,
          fontWeight: .w500,
          color: Color(0xFF4E342E),
          height: 1.5,
        ),
        labelLarge: GoogleFonts.epilogue(
          fontSize: 12,
          color: Color(0xFF4E342E),
          fontWeight: .w500,
          height: 1.5,
        ),
        labelSmall: GoogleFonts.epilogue(
          fontSize: 11,
          color: Color(0xFF4E342E),
          fontWeight: .w500,
          height: 1.5,
        ),
      );
}
