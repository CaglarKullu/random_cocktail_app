import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_cocktail_app/consts/text_style.dart';
import 'package:random_cocktail_app/data/database.dart';
import 'package:random_cocktail_app/data/local_db.dart';
import 'package:random_cocktail_app/models/ingredients.dart';
import 'package:random_cocktail_app/widgets/screens/log_in_widgets/login_screen.dart';
import 'package:random_cocktail_app/widgets/screens/logged_in_widgets/custom_fab.dart';
import 'package:random_cocktail_app/widgets/screens/logged_in_widgets/logged_in_screen.dart';
import 'package:random_cocktail_app/widgets/screens/my_favorites/my_favorites.dart';

class FavoriteCocktail extends ConsumerStatefulWidget {
  final String drinkName;
  final String drinkId;
  final String drinkThumb;
  final String instructions;
  final String category;
  final String glass;
  final List<Ingredient> ingredientList;
  const FavoriteCocktail(
      {super.key,
      required this.drinkName,
      required this.drinkId,
      required this.drinkThumb,
      required this.instructions,
      required this.category,
      required this.glass,
      required this.ingredientList});

  @override
  ConsumerState<FavoriteCocktail> createState() => _FavoriteCocktailState();
}

class _FavoriteCocktailState extends ConsumerState<FavoriteCocktail> {
  int _counter = 0;
  bool isB52 = false;
  _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _refreshRamdomDrink() => setState(() {
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
    List<Ingredient> ingredientList = widget.ingredientList;
    ingredientList.removeWhere((element) => element.ingredientName == null);

    final user = ref.refresh(userProvider);
    final ScrollController controllerOne = ScrollController();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: NestedScrollView(
          controller: controllerOne,
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
                    SliverAppBar(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.white,
                      expandedHeight: MediaQuery.of(context).size.height / 2,
                      elevation: 0,
                      flexibleSpace: Container(
                        alignment: Alignment.topRight,
                        height: size.height / 2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: NetworkImage(widget.drinkThumb)),
                        ),
                      ),
                    )
                  ],
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                            widget.drinkName,
                            style: titleTextStyle,
                          ),
                        ),
                        IconButton(
                          iconSize: 30,
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: (() {
                            unLikeAlert(size, user);
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          "Ingredients",
                          style: titleTextStyle,
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.ingredientList.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          leading: Text(
                            widget.ingredientList[index].ingredientName ?? "",
                            style: textStyle,
                          ),
                          trailing: Text(
                            widget.ingredientList[index].ingredientmeasure ??
                                "",
                            style: textStyle,
                          ),
                        );
                      })),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15),
                        child: Text(
                          "Instructions",
                          style: titleTextStyle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      widget.instructions,
                      textAlign: TextAlign.justify,
                      style: textStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          )),
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
                      if (user!.isAnonymous) {
                        toLikeAlert(size);
                      } else {
                        isButtonOneSelected = false;
                        isButtonTwoSelected = true;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyFavorites(
                                    uid: user.uid,
                                  )),
                        );
                      }
                    });
                  });
                },
                buttonText: "My Favorites",
                isButtonSelected: isButtonTwoSelected),
          ],
        ),
      ),
    ));
  }

  void toLikeAlert(Size size) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              title: Wrap(children: const [Text("Like this cocktail")]),
              content: SizedBox(
                width: size.width / 3,
                height: size.height / 5,
                child: Center(
                    child: Wrap(children: const [
                  Text(
                      "If you want to like your drink, you should be logged in. Do you want to continue?"),
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LogInScreen()),
                      );
                    },
                    child: Text(
                      "Log in",
                      style: unselectedButtonTextStyle,
                    )),
              ],
            ));
  }

  void unLikeAlert(Size size, User? user) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              title: Wrap(children: [Text("Unlike ${widget.drinkName}?")]),
              content: SizedBox(
                width: size.width / 3,
                height: size.height / 5,
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
                      ref.read(db).value?.removeFromFavorite(widget.drinkName);
                      ref.read(localDBProvider).deleteCocktail(widget.drinkId);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyFavorites(
                                  uid: user?.uid,
                                )),
                      );
                    },
                    child: Text(
                      "Unlike",
                      style: unselectedButtonTextStyle,
                    )),
              ],
            ));
  }
}
