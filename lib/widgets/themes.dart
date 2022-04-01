import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static ThemeData lightTheme() => ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: GoogleFonts.lato().fontFamily,
        cardColor: Colors.white,
        canvasColor: creamColor,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: darkCreamColor),
        appBarTheme: AppBarTheme(
          actionsIconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: creamColor,
          elevation: 4,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
      );
  static ThemeData darkTheme() => ThemeData(
        // primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
        fontFamily: GoogleFonts.lato().fontFamily,
        cardColor: Colors.black,
        canvasColor: darkCreamColor,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Colors.white, brightness: Brightness.dark),

        appBarTheme: AppBarTheme(
          actionsIconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(
            color: Colors.white,
          ),
          backgroundColor: darkCreamColor,
          elevation: 4,
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
        ),
      );

  // static Color whitish = const Color(0xFFFAFAFA);
  static Color creamColor = const Color(0xfff5f5f5);
  static Color black = const Color(0xff181818);
  static Color darkCreamColor = const Color(0xFF18181B);
  static Color darkBluishColor = const Color(0xff403b58);
  static Color lightBluishColor = const Color(0xFF6366F1);
}
