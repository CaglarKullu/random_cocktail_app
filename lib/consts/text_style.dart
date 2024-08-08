import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as fonts;
import 'package:random_cocktail_app/consts/color.dart';

TextStyle textStyle =fonts.GoogleFonts.roboto(
  fontSize: 15,
  color: textColor,
  fontWeight: FontWeight.normal,
);
TextStyle titleTextStyle = fonts.GoogleFonts.roboto(
  fontSize: 25,
  color: textColor,
  fontWeight: FontWeight.bold,
);
TextStyle selectedButtonTextStyle = fonts.GoogleFonts.roboto(
  fontSize: 15,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

TextStyle unselectedButtonTextStyle = fonts.GoogleFonts.roboto(
  fontSize: 15,
  color: selectedNavItemColor,
  fontWeight: FontWeight.bold,
);
TextStyle cancelButtonTextStyle = fonts.GoogleFonts.roboto(
  fontSize: 15,
  color: cancelButTextColor,
  fontWeight: FontWeight.bold,
);
