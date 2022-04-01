import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text appBarTitle(String text, BuildContext context) {
  return Text(
    text,
    style: TextStyle(
      color: Theme.of(context).colorScheme.secondary,
      fontSize: 30,
      fontFamily: GoogleFonts.italianno().fontFamily,
    ),
  );
}
