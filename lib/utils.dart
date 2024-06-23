import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextTheme textTheme = TextTheme(
    // Used fonts (Don't change the following)
    displayLarge: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 42,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.4),
    displayMedium: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 32,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.4),
    titleLarge: GoogleFonts.poppins(
        color: const Color.fromRGBO(16, 12, 8, 1),
        fontWeight: FontWeight.w600,
        fontSize: 20),
    titleMedium: GoogleFonts.poppins(
        color: Colors.black,
        fontStyle: FontStyle.normal,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.4),
    labelMedium: GoogleFonts.poppins(
        color: const Color.fromRGBO(16, 12, 8, 1),
        fontWeight: FontWeight.w400,
        fontSize: 14),
    labelSmall: GoogleFonts.poppins(
        color: const Color.fromRGBO(16, 12, 8, 1),
        fontWeight: FontWeight.w400,
        fontSize: 11),
    titleSmall: GoogleFonts.poppins(
        color: const Color.fromRGBO(16, 12, 8, 1),
        fontWeight: FontWeight.w600,
        fontSize: 14),
    bodyLarge: GoogleFonts.poppins(
        color: const Color.fromRGBO(16, 12, 8, 1),
        fontWeight: FontWeight.w600,
        fontSize: 24),
    bodyMedium: GoogleFonts.poppins(
        color: Colors.black,
        fontStyle: FontStyle.normal,
        fontSize: 16,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w400),
    bodySmall: GoogleFonts.poppins(
        color: Colors.black,
        fontStyle: FontStyle.normal,
        fontSize: 12,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w500),

    //Following fonts are not used in the app
    displaySmall: GoogleFonts.poppins(
        color: Colors.black,
        fontStyle: FontStyle.normal,
        fontSize: 18,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w400),

    headlineMedium: GoogleFonts.poppins(
        color: Colors.black,
        fontStyle: FontStyle.normal,
        fontSize: 14,
        fontWeight: FontWeight.w500),
  );
}
