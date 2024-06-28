import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white),
    cardColor: Colors.white,
    primaryColor: const Color(0xffF7F6F2),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xfff7f6f4)),
    scaffoldBackgroundColor: const Color(0xfff7f6f3),
    textTheme: TextTheme(
        bodySmall: GoogleFonts.roboto(
            textStyle: const TextStyle(
                color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400)),
        titleMedium: GoogleFonts.roboto(
            textStyle: const TextStyle(
                color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400)),
        titleLarge:
            GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 32))));
