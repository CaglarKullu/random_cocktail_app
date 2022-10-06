import 'package:flutter/material.dart';
import 'package:random_cocktail_app/consts/color.dart';
import 'package:random_cocktail_app/consts/text_style.dart';

class CustomFab extends StatelessWidget {
  const CustomFab({
    super.key,
    this.onPressed,
    required this.buttonText,
    required this.isButtonSelected,
  });
  final VoidCallback? onPressed;
  final String buttonText;
  final bool isButtonSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 187,
      height: 50,
      child: FloatingActionButton(
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
