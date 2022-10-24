import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_cocktail_app/consts/color.dart';

TextStyle textStyle = GoogleFonts.roboto(
  fontSize: 15,
  color: textColor,
  fontWeight: FontWeight.normal,
);
TextStyle titleTextStyle = GoogleFonts.roboto(
  fontSize: 25,
  color: textColor,
  fontWeight: FontWeight.bold,
);
TextStyle selectedButtonTextStyle = GoogleFonts.roboto(
  fontSize: 15,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

TextStyle unselectedButtonTextStyle = GoogleFonts.roboto(
  fontSize: 15,
  color: selectedNavItemColor,
  fontWeight: FontWeight.bold,
);
TextStyle cancelButtonTextStyle = GoogleFonts.roboto(
  fontSize: 15,
  color: cancelButTextColor,
  fontWeight: FontWeight.bold,
);
