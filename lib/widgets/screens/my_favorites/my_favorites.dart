import 'dart:developer';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:random_cocktail_app/consts/color.dart';
import 'package:random_cocktail_app/consts/text_style.dart';
import 'package:random_cocktail_app/data/auth.dart';
import 'package:random_cocktail_app/data/database.dart';
import 'package:random_cocktail_app/data/local_db.dart';
import 'package:random_cocktail_app/models/ingredients.dart';
import 'package:random_cocktail_app/widgets/screens/home_screen.dart';

import 'package:random_cocktail_app/widgets/screens/logged_in_widgets/custom_fab.dart';
import 'package:random_cocktail_app/widgets/screens/logged_in_widgets/logged_in_screen.dart';
import 'package:random_cocktail_app/widgets/screens/my_favorites/favorite_cocktail.dart';

import '../../../data/api_service/random_cocktail_api.dart';

// ignore: must_be_immutable
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
    Size size = MediaQuery.of(context).size;
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
        body: Column(
          children: [
            Flexible(
              child: Center(
                child: Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    final cocktailList =
                        ref.watch(cocktailListProvider(widget.uid));

                    return cocktailList.when(
                        data: (data) {
                          return data.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(FontAwesome.folder_empty),
                                      Text("No Liked Drinks so far"),
                                    ],
                                  ),
                                )
                              : GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent:
                                        MediaQuery.of(context).size.width / 2,
                                    childAspectRatio: 1,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                  ),
                                  itemCount: data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var info = data[index];

                                    return InkWell(
                                      onTap: () => Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FavoriteCocktail(
                                                      drinkId: info.idDrink!,
                                                      ingredientList: [
                                                        Ingredient(
                                                            ingredientName: info
                                                                .strIngredient1,
                                                            ingredientmeasure:
                                                                info.strMeasure1),
                                                        Ingredient(
                                                            ingredientName: info
                                                                .strIngredient2,
                                                            ingredientmeasure:
                                                                info.strMeasure2),
                                                        Ingredient(
                                                            ingredientName: info
                                                                .strIngredient3,
                                                            ingredientmeasure:
                                                                info.strMeasure3),
                                                        Ingredient(
                                                            ingredientName: info
                                                                .strIngredient4,
                                                            ingredientmeasure:
                                                                info.strMeasure4),
                                                        Ingredient(
                                                            ingredientName: info
                                                                .strIngredient5,
                                                            ingredientmeasure:
                                                                info.strMeasure5),
                                                        Ingredient(
                                                            ingredientName: info
                                                                .strIngredient6,
                                                            ingredientmeasure:
                                                                info.strMeasure6),
                                                        Ingredient(
                                                            ingredientName: info
                                                                .strIngredient7,
                                                            ingredientmeasure:
                                                                info.strMeasure7),
                                                        Ingredient(
                                                            ingredientName: info
                                                                .strIngredient8,
                                                            ingredientmeasure:
                                                                info.strMeasure8),
                                                        Ingredient(
                                                            ingredientName: info
                                                                .strIngredient9,
                                                            ingredientmeasure:
                                                                info.strMeasure9),
                                                        Ingredient(
                                                            ingredientName: info
                                                                .strIngredient10,
                                                            ingredientmeasure:
                                                                info.strMeasure10),
                                                        Ingredient(
                                                            ingredientName: info
                                                                .strIngredient11,
                                                            ingredientmeasure:
                                                                info.strMeasure11),
                                                        Ingredient(
                                                            ingredientName: info
                                                                .strIngredient12,
                                                            ingredientmeasure:
                                                                info.strMeasure12),
                                                        Ingredient(
                                                            ingredientName: info
                                                                .strIngredient13,
                                                            ingredientmeasure:
                                                                info.strMeasure13),
                                                        Ingredient(
                                                            ingredientName: info
                                                                .strIngredient14,
                                                            ingredientmeasure:
                                                                info.strMeasure14),
                                                        Ingredient(
                                                            ingredientName: info
                                                                .strIngredient15,
                                                            ingredientmeasure:
                                                                info.strMeasure15),
                                                      ],
                                                      drinkName:
                                                          info.drinkName!,
                                                      drinkThumb:
                                                          info.drinkThumb!,
                                                      instructions:
                                                          info.instructions!,
                                                      category: info.category!,
                                                      glass: info.glass!))),
                                      child: Card(
                                        color: Colors.white24,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    info.drinkThumb!)),
                                          ),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                  iconSize: 30,
                                                  icon: const Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: (() {
                                                    unLikeAlert(
                                                        size,
                                                        user,
                                                        info.drinkName,
                                                        info.idDrink);
                                                  }),
                                                ),
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                          sigmaX: 10.0,
                                                          sigmaY: 10.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                border: Border.all(
                                                                    width: 2,
                                                                    color: Colors
                                                                        .white30),
                                                                gradient:
                                                                    const LinearGradient(
                                                                  colors: [
                                                                    Colors
                                                                        .white60,
                                                                    Colors
                                                                        .white10
                                                                  ],
                                                                  begin: Alignment
                                                                      .topLeft,
                                                                  end: Alignment
                                                                      .bottomCenter,
                                                                )),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            data[index]
                                                                .drinkName!,
                                                            style:
                                                                selectedButtonTextStyle,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
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
            ),
            const SizedBox(
              height: 60,
            )
          ],
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

  void unLikeAlert(Size size, User user, String? drinkName, String? idDrink) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              title: Wrap(children: [Text("Unlike $drinkName?")]),
              content: SizedBox(
                width: size.width / 4,
                height: size.height / 10,
                child: Center(
                    child: Wrap(children: const [
                  Text(
                      "If you unlike your drink, you may not be able to see it again. Do you want to continue?"),
                ])),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: cancelButtonTextStyle,
                    )),
                TextButton(
                    onPressed: () {
                      ref.read(db).value?.removeFromFavorite(drinkName!);
                      ref.read(localDBProvider).deleteCocktail(idDrink!);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Unlike",
                      style: unselectedButtonTextStyle,
                    )),
              ],
            ));
  }
}
