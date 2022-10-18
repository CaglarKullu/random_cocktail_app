import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_cocktail_app/consts/color.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

TextStyle textStyle = GoogleFonts.roboto(
  fontSize: 15.sp,
  color: textColor,
  fontWeight: FontWeight.normal,
);
TextStyle titleTextStyle = GoogleFonts.roboto(
  fontSize: 25.sp,
  color: textColor,
  fontWeight: FontWeight.bold,
);
TextStyle selectedButtonTextStyle = GoogleFonts.roboto(
  fontSize: 15.sp,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

TextStyle unselectedButtonTextStyle = GoogleFonts.roboto(
  fontSize: 15.sp,
  color: selectedNavItemColor,
  fontWeight: FontWeight.bold,
);
