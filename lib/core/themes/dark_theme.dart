import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData(
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  cardColor: const Color(0xff3C3C3F),
  colorScheme:
      ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
  inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: Colors.white),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      filled: true,
      fillColor: const Color(0xff3C3C3F)),
  textTheme: TextTheme(
      bodyMedium: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 16)),
      bodySmall: GoogleFonts.roboto(
          textStyle: const TextStyle(
              color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400)),
      titleMedium: GoogleFonts.roboto(
          textStyle: const TextStyle(
              color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400)),
      titleLarge: GoogleFonts.roboto(
          textStyle: const TextStyle(fontSize: 32, color: Colors.white))),
);
