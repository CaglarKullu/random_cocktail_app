import 'dart:developer';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_cocktail_app/consts/color.dart';
import 'package:random_cocktail_app/consts/text_style.dart';
import 'package:random_cocktail_app/data/auth.dart';
import 'package:random_cocktail_app/data/database.dart';
import 'package:random_cocktail_app/models/ingredients.dart';
import 'package:random_cocktail_app/widgets/screens/home_screen.dart';
import 'package:random_cocktail_app/widgets/screens/logged_in_widgets/cocktail_detail.dart';
import 'package:random_cocktail_app/widgets/screens/logged_in_widgets/custom_fab.dart';
import 'package:random_cocktail_app/widgets/screens/logged_in_widgets/logged_in_screen.dart';
import 'package:random_cocktail_app/widgets/screens/my_favorites/favorite_cocktail.dart';

import '../../../data/api_service/random_cocktail_api.dart';

class MyFavorites extends ConsumerStatefulWidget {
  String? uid;
  MyFavorites({required this.uid, super.key});

  @override
  ConsumerState<MyFavorites> createState() => _MyFavoritesState();
}

class _MyFavoritesState extends ConsumerState<MyFavorites> {
  int _counter = 0;
  bool isB52 = false;
  _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _refreshRamdomDrink() => setState(() {
        ref.refresh(randomDrink);
        if (_counter == 52) {
          isB52 = true;
        }
        if (_counter > 52) {
          isB52 = false;
        }
      });

  bool isButtonOneSelected = false;
  bool isButtonTwoSelected = true;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final signIn = ref.read(authProvider);
    bool isLongName = false;
    if (user!.displayName!.length > 20) {
      isLongName = true;
    }
    return SafeArea(
        child: WillPopScope(
      onWillPop: () async {
        log("Back button pressed");
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return TextButton(
                    onPressed: () {
                      user.isAnonymous
                          ? signIn.anonLogout()
                          : signIn.googleLogout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
                    child: user.isAnonymous
                        ? const SizedBox()
                        : const Text(
                            "Log Out",
                            style: TextStyle(color: signUpButTextColor),
                          ));
              },
            )
          ],
          title: Text(
            isLongName ? "My Favorites" : "${user.displayName}'s Favorites",
            style: const TextStyle(
                color: selectedNavItemColor, fontWeight: FontWeight.bold),
          ),
          backgroundColor: menuBackgroundColor,
        ),
        body: Center(
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final cocktailList = ref.watch(cocktailListProvider(widget.uid));
              List<Ingredient> ingredientList = [];
              return cocktailList.when(
                  data: (data) {
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width / 2,
                          childAspectRatio: 1,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          ingredientList.add(
                            Ingredient(
                              ingredientName: data[index].strIngredientName,
                              ingredientmeasure:
                                  data[index].strIngredientMeasure,
                            ),
                          );

                          return InkWell(
                            onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FavoriteCocktail(
                                        drinkId: data[index].idDrink!,
                                        ingredientList: ingredientList,
                                        drinkName: data[index].drinkName!,
                                        drinkThumb: data[index].drinkThumb!,
                                        instructions: data[index].instructions!,
                                        category: data[index].category!,
                                        glass: data[index].glass!))),
                            child: Card(
                              color: Colors.white24,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          data[index].drinkThumb!)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 10.0, sigmaY: 10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.white30),
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Colors.white60,
                                                  Colors.white10
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomCenter,
                                              )),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              data[index].drinkName!,
                                              style: selectedButtonTextStyle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  error: (e, stack) => Text('$e'),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()));
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomFab(
                heroTag: "btn1",
                onPressed: () {
                  setState(() {
                    isButtonOneSelected = true;
                    isButtonTwoSelected = false;
                    _incrementCounter();
                    _refreshRamdomDrink();
                  });
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LogedInScreen(title: ""),
                      ));
                },
                buttonText: "Surprise me!",
                isButtonSelected: isButtonOneSelected,
              ),
              CustomFab(
                  heroTag: "btn2",
                  onPressed: () {
                    setState(() {
                      setState(() {
                        isButtonOneSelected = false;
                        isButtonTwoSelected = true;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyFavorites(
                                    uid: user.uid,
                                  )),
                        );
                      });
                    });
                  },
                  buttonText: "My Favorites",
                  isButtonSelected: isButtonTwoSelected),
            ],
          ),
        ),
      ),
    ));
  }
}
