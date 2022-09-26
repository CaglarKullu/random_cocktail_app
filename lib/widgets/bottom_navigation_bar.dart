import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:random_cocktail_app/consts/color.dart';

class CustomNavigationBar extends StatefulWidget {
  int selectedIndex = 0;
  CustomNavigationBar({required this.selectedIndex, super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BottomNavigationBar(
          currentIndex: widget.selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: selectedNavItemColor,
          items: [
            BottomNavigationBarItem(
                icon: IconButton(
                  icon: const Icon(FontAwesome5.cocktail),
                  onPressed: () {},
                ),
                label: "Random Cocktail"),
            BottomNavigationBarItem(
                icon: IconButton(
                  icon: const Icon(Icons.favorite),
                  onPressed: () {},
                ),
                label: "My Favorite"),
          ]),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }
}
