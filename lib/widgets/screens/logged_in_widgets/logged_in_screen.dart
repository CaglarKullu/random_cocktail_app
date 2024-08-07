import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_cocktail_app/consts/text_style.dart';

import 'package:random_cocktail_app/data/api_service/random_cocktail_api.dart';
import 'package:random_cocktail_app/data/auth.dart';
import 'package:random_cocktail_app/data/database.dart';

import 'package:random_cocktail_app/models/ingredients.dart';
import 'package:random_cocktail_app/widgets/screens/home_screen.dart';
import 'package:random_cocktail_app/widgets/screens/logged_in_widgets/cocktail_detail.dart';
import 'package:random_cocktail_app/widgets/screens/logged_in_widgets/custom_fab.dart';
import 'package:random_cocktail_app/widgets/screens/my_favorites/my_favorites.dart';

class LogedInScreen extends ConsumerStatefulWidget {
  const LogedInScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  ConsumerState<LogedInScreen> createState() => _LogedInScreenState();
}

class _LogedInScreenState extends ConsumerState<LogedInScreen> {
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
  bool isLiked = false;
  bool isButtonOneSelected = true;
  bool isButtonTwoSelected = false;
  DateTime timeBackPressed = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final drink = isB52 ? ref.watch(fetchDrinkB52) : ref.watch(randomDrink);
    final user = ref.watch(userProvider);
    final dbHelp = ref.read(db);
    final ScrollController controllerOne = ScrollController();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final dif = DateTime.now().difference(timeBackPressed);
          final exitWarning = dif >= const Duration(seconds: 2);
          timeBackPressed = DateTime.now();
          if (exitWarning) {
            String msg = "Press back again to exit";
            Fluttertoast.showToast(msg: msg, fontSize: 18);
            return false;
          } else {
            Fluttertoast.cancel();
            return true;
          }
        },
        child: Scaffold(
          body: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return drink.when(
                  data: ((data) {
                    var info = data.randomCocktail[0];
                    return NestedScrollView(
                      controller: controllerOne,
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) => [
                        SliverAppBar(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.white,
                          expandedHeight:
                              MediaQuery.of(context).size.height / 2,
                          elevation: 0,
                          flexibleSpace: Container(
                            alignment: Alignment.topRight,
                            height: size.height / 2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: NetworkImage(
                                      data.randomCocktail[0].drinkThumb!)),
                            ),
                          ),
                        )
                      ],
                      body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Scrollbar(
                                radius: const Radius.circular(20),
                                thumbVisibility: true,
                                trackVisibility: true,
                                thickness: 5,
                                controller: controllerOne,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      CocktailDetail(
                                        onPressedLiked: (() {
                                          user!.isAnonymous
                                              ? toLikeAlert(size)
                                              : dbHelp.whenData((value) =>
                                                  value.addFavorite(info));
                                        }),
                                        onPressedUnLiked: (() {
                                          ref
                                              .read(db)
                                              .value
                                              ?.removeFromFavorite(
                                                  info.drinkName!);
                                        }),
                                        ingredientList: [
                                          Ingredient(
                                              ingredientName:
                                                  info.strIngredient1,
                                              ingredientmeasure:
                                                  info.strMeasure1),
                                          Ingredient(
                                              ingredientName:
                                                  info.strIngredient2,
                                              ingredientmeasure:
                                                  info.strMeasure2),
                                          Ingredient(
                                              ingredientName:
                                                  info.strIngredient3,
                                              ingredientmeasure:
                                                  info.strMeasure3),
                                          Ingredient(
                                              ingredientName:
                                                  info.strIngredient4,
                                              ingredientmeasure:
                                                  info.strMeasure4),
                                          Ingredient(
                                              ingredientName:
                                                  info.strIngredient5,
                                              ingredientmeasure:
                                                  info.strMeasure5),
                                          Ingredient(
                                              ingredientName:
                                                  info.strIngredient6,
                                              ingredientmeasure:
                                                  info.strMeasure6),
                                          Ingredient(
                                              ingredientName:
                                                  info.strIngredient7,
                                              ingredientmeasure:
                                                  info.strMeasure7),
                                          Ingredient(
                                              ingredientName:
                                                  info.strIngredient8,
                                              ingredientmeasure:
                                                  info.strMeasure8),
                                          Ingredient(
                                              ingredientName:
                                                  info.strIngredient9,
                                              ingredientmeasure:
                                                  info.strMeasure9),
                                          Ingredient(
                                              ingredientName:
                                                  info.strIngredient10,
                                              ingredientmeasure:
                                                  info.strMeasure10),
                                          Ingredient(
                                              ingredientName:
                                                  info.strIngredient11,
                                              ingredientmeasure:
                                                  info.strMeasure11),
                                          Ingredient(
                                              ingredientName:
                                                  info.strIngredient12,
                                              ingredientmeasure:
                                                  info.strMeasure12),
                                          Ingredient(
                                              ingredientName:
                                                  info.strIngredient13,
                                              ingredientmeasure:
                                                  info.strMeasure13),
                                          Ingredient(
                                              ingredientName:
                                                  info.strIngredient14,
                                              ingredientmeasure:
                                                  info.strMeasure14),
                                          Ingredient(
                                              ingredientName:
                                                  info.strIngredient15,
                                              ingredientmeasure:
                                                  info.strMeasure15),
                                        ],
                                        drinkId: info.idDrink!,
                                        drinkName: info.drinkName!,
                                        drinkThumb: info.drinkThumb!,
                                        instructions: info.instructions!,
                                        category: info.category!,
                                        glass: info.glass!,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  error: (e, stack) => Text('$e'),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()));
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
                  },
                  buttonText: "Surprise me!",
                  isButtonSelected: isButtonOneSelected,
                ),
                CustomFab(
                    heroTag: "btn2",
                    onPressed: () {
                      setState(() {
                        setState(() {
                          ref.refresh(authProvider);
                          isButtonOneSelected = false;
                          isButtonTwoSelected = true;
                          user!.isAnonymous
                              ? toLikeAlert(size)
                              : Navigator.pushReplacement(
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
      ),
    );
  }

  void toLikeAlert(Size size) {
    ref.refresh(authProvider);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              title: const Wrap(children: [Text("To like")]),
              content: SizedBox(
                width: size.width / 3,
                height: size.height / 5,
                child: const Center(
                    child: Wrap(children: [
                  Text(
                      "If you want to like your drink or to see your favorite's page, you should be logged in. Do you want to continue?"),
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
                      ref.read(authProvider).anonLogout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
                    child: Text(
                      "Log in",
                      style: unselectedButtonTextStyle,
                    )),
              ],
            ));
  }
}
