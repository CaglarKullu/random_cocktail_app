import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:random_cocktail_app/consts/color.dart';
import 'package:random_cocktail_app/data/api_service/random_cocktail_api.dart';
import 'package:random_cocktail_app/widgets/screens/logged_in_screen.dart';
import 'package:random_cocktail_app/widgets/screens/my_favorites.dart';

class CustomNavigationBar extends ConsumerStatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  ConsumerState<CustomNavigationBar> createState() =>
      _CustomNavigationBarState();
}

class _CustomNavigationBarState extends ConsumerState<CustomNavigationBar> {
  static List<Widget> pages = [
    const LogedInScreen(title: "Random Cocktail App"),
    const MyFavorites(),
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      ref.refresh(randomDrink);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BottomNavigationBar(
            showSelectedLabels: false,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: selectedNavItemColor,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.black,
                label: "Surprise me!",
                icon: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade800,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(5, 5),
                        blurRadius: 10,
                        spreadRadius: 0.5,
                      ),
                      BoxShadow(
                        color: Colors.grey.shade600,
                        offset: Offset(-4, -4),
                        blurRadius: 10,
                        spreadRadius: 0.5,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        FontAwesome5.cocktail,
                      ),
                      Text("Surprise me!")
                    ],
                  ),
                ),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "My Favorite"),
            ]),
      ),
    );
  }
}
