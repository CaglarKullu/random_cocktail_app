import 'package:flutter/material.dart';
import 'package:random_cocktail_app/consts/color.dart';
import 'package:random_cocktail_app/consts/text_style.dart';

class CustomFab extends StatelessWidget {
  const CustomFab({
    super.key,
    this.onPressed,
    required this.buttonText,
    required this.isButtonSelected,
    required this.heroTag,
  });
  final VoidCallback? onPressed;
  final String buttonText;
  final bool isButtonSelected;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double width;
    if (deviceWidth > 410) {
      width = 187;
    } else {
      width = 170;
    }
    return SizedBox(
      width: width,
      height: 50,
      child: FloatingActionButton(
        heroTag: heroTag,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onPressed,
        backgroundColor:
            isButtonSelected ? selectedNavItemColor : menuBackgroundColor,
        child: Text(
          buttonText,
          style: isButtonSelected
              ? selectedButtonTextStyle
              : unselectedButtonTextStyle,
        ),
      ),
    );
  }
}
