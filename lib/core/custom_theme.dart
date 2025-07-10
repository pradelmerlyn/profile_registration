
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.redAccent,
        primary: Colors.redAccent, // for background
        onPrimary: Colors.white, // for text/icons on red
        secondary: Colors.grey,
        tertiary: const Color.fromRGBO(235, 235, 235, 1),
        brightness: Brightness.dark,
      ),
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: GoogleFonts.oswald(
          fontSize: 30,
          fontStyle: FontStyle.italic,
        ),
        bodyMedium: GoogleFonts.merriweather(),
        displaySmall: GoogleFonts.pacifico(),
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromRGBO(70, 150, 255, 1),
        primary: const Color.fromRGBO(70, 150, 255, 1), // for background
        onPrimary: Colors.white, // for text/icons
        secondary:const Color.fromRGBO(235, 235, 235, 1),
        onSecondary: const Color.fromARGB(255, 100, 99, 99),
        tertiary: Colors.black,
        onError: Colors.red,
        brightness: Brightness.light,
      ),
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: GoogleFonts.oswald(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: GoogleFonts.poppins(),
        displaySmall: GoogleFonts.inter(),
      ),
      useMaterial3: true,
    );
  }
}
