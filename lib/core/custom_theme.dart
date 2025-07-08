
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
        onPrimary: Colors.white, // for text/icons on red
        secondary:const Color.fromRGBO(238, 238, 238, 1),
        tertiary: Colors.black,
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
        titleSmall: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: GoogleFonts.poppins(),
        displaySmall: GoogleFonts.inter(),
      ),
      useMaterial3: true,
    );
  }
}
