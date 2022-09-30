import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_cocktail_app/consts/color.dart';

Widget buildTitleAndLogo(Size deviceSize) {
  return Positioned.fill(
    top: deviceSize.height / 10,
    right: deviceSize.width / 4,
    child: Align(
      alignment: Alignment.centerRight,
      child: Column(
        children: [
          Text(
            "Surprise me",
            style: GoogleFonts.roboto(
              fontSize: 25,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(100),
              color: iconBackgroundColor,
              image: const DecorationImage(
                  image: AssetImage("assets/appicon.png"), fit: BoxFit.fill),
            ),
            child: Image.asset("assets/appicon.png"),
          ),
        ],
      ),
    ),
  );
}
