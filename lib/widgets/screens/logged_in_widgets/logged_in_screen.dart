import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:random_cocktail_app/consts/color.dart';
import 'package:random_cocktail_app/data/api_service/random_cocktail_api.dart';

import 'package:random_cocktail_app/data/auth.dart';
import 'package:random_cocktail_app/data/database.dart';

import 'package:random_cocktail_app/models/ingredients.dart';
import 'package:random_cocktail_app/models/random_cocktail.dart';
import 'package:random_cocktail_app/widgets/screens/logged_in_widgets/cocktail_detail.dart';
import 'package:random_cocktail_app/widgets/screens/logged_in_widgets/custom_fab.dart';

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

  bool isButtonOneSelected = false;
  bool isButtonTwoSelected = false;

  @override
  Widget build(BuildContext context) {
    final drink = isB52 ? ref.watch(fetchDrinkB52) : ref.watch(randomDrink);
    final user = FirebaseAuth.instance.currentUser;
    final signIn = ref.read(authProvider);
    final dbHelp = ref.read(db);
    final ScrollController controllerOne = ScrollController();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        /* appBar: AppBar(
          actions: [
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return TextButton(
                    onPressed: () => user!.isAnonymous
                        ? signIn.anonLogout()
                        : signIn.googleLogout(),
                    child: user!.isAnonymous
                        ? const SizedBox()
                        : const Text("Log Out"));
              },
            )
          ],
          backgroundColor: appBarColor,
          title: Text(widget.title),
        ),*/

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
                        expandedHeight: MediaQuery.of(context).size.height / 2,
                        elevation: 0,
                        flexibleSpace: Container(
                          alignment: Alignment.topRight,
                          height: size.height / 2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: NetworkImage(
                                    data.randomCocktail[0].drinkThumb)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: IconButton(
                              iconSize: 30,
                              icon: const Icon(Icons.favorite_border_rounded),
                              onPressed: (() {
                                dbHelp.whenData(
                                    (value) => value.addFavorite(RandomCocktail(
                                          drinkName: info.drinkName,
                                          drinkThumb: info.drinkThumb,
                                          idDrink: info.idDrink,
                                          instructions: info.instructions,
                                          category: info.category,
                                          glass: info.glass,
                                          strIngredient1: info.strIngredient1,
                                          strIngredient2: info.strIngredient2,
                                          strIngredient3: info.strIngredient3,
                                          strIngredient4: info.strIngredient4,
                                          strIngredient5: info.strIngredient5,
                                          strIngredient6: info.strIngredient6,
                                          strIngredient7: info.strIngredient7,
                                          strIngredient8: info.strIngredient8,
                                          strIngredient9: info.strIngredient9,
                                          strIngredient10: info.strIngredient10,
                                          strIngredient11: info.strIngredient11,
                                          strIngredient12: info.strIngredient12,
                                          strIngredient13: info.strIngredient13,
                                          strIngredient14: info.strIngredient14,
                                          strIngredient15: info.strIngredient15,
                                          strMeasure1: info.strMeasure1,
                                          strMeasure2: info.strMeasure2,
                                          strMeasure3: info.strMeasure3,
                                          strMeasure4: info.strMeasure4,
                                          strMeasure5: info.strMeasure5,
                                          strMeasure6: info.strMeasure6,
                                          strMeasure7: info.strMeasure7,
                                          strMeasure8: info.strMeasure8,
                                          strMeasure9: info.strMeasure9,
                                          strMeasure10: info.strIngredient10,
                                          strMeasure11: info.strIngredient11,
                                          strMeasure12: info.strMeasure12,
                                          strMeasure13: info.strMeasure13,
                                          strMeasure14: info.strIngredient14,
                                          strMeasure15: info.strMeasure15,
                                        )));
                              }),
                            ),
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
                                child: CocktailDetail(
                                    ingredientList: [
                                      Ingredient(
                                          ingredientName: data
                                              .randomCocktail[0].strIngredient1,
                                          ingredientmeasure: data
                                              .randomCocktail[0].strMeasure1),
                                      Ingredient(
                                          ingredientName: data
                                              .randomCocktail[0].strIngredient2,
                                          ingredientmeasure: data
                                              .randomCocktail[0].strMeasure2),
                                      Ingredient(
                                          ingredientName: data
                                              .randomCocktail[0].strIngredient3,
                                          ingredientmeasure: data
                                              .randomCocktail[0].strMeasure3),
                                      Ingredient(
                                          ingredientName: data
                                              .randomCocktail[0].strIngredient4,
                                          ingredientmeasure: data
                                              .randomCocktail[0].strMeasure4),
                                      Ingredient(
                                          ingredientName: data
                                              .randomCocktail[0].strIngredient5,
                                          ingredientmeasure: data
                                              .randomCocktail[0].strMeasure5),
                                      Ingredient(
                                          ingredientName: data
                                              .randomCocktail[0].strIngredient6,
                                          ingredientmeasure: data
                                              .randomCocktail[0].strMeasure6),
                                      Ingredient(
                                          ingredientName: data
                                              .randomCocktail[0].strIngredient7,
                                          ingredientmeasure: data
                                              .randomCocktail[0].strMeasure7),
                                      Ingredient(
                                          ingredientName: data
                                              .randomCocktail[0].strIngredient8,
                                          ingredientmeasure: data
                                              .randomCocktail[0].strMeasure8),
                                      Ingredient(
                                          ingredientName: data
                                              .randomCocktail[0].strIngredient9,
                                          ingredientmeasure: data
                                              .randomCocktail[0].strMeasure9),
                                      Ingredient(
                                          ingredientName: data.randomCocktail[0]
                                              .strIngredient10,
                                          ingredientmeasure: data
                                              .randomCocktail[0].strMeasure10),
                                      Ingredient(
                                          ingredientName: data.randomCocktail[0]
                                              .strIngredient11,
                                          ingredientmeasure: data
                                              .randomCocktail[0].strMeasure11),
                                      Ingredient(
                                          ingredientName: data.randomCocktail[0]
                                              .strIngredient12,
                                          ingredientmeasure: data
                                              .randomCocktail[0].strMeasure12),
                                      Ingredient(
                                          ingredientName: data.randomCocktail[0]
                                              .strIngredient13,
                                          ingredientmeasure: data
                                              .randomCocktail[0].strMeasure13),
                                      Ingredient(
                                          ingredientName: data.randomCocktail[0]
                                              .strIngredient14,
                                          ingredientmeasure: data
                                              .randomCocktail[0].strMeasure14),
                                      Ingredient(
                                          ingredientName: data.randomCocktail[0]
                                              .strIngredient15,
                                          ingredientmeasure: data
                                              .randomCocktail[0].strMeasure15),
                                    ],
                                    drinkName: data.randomCocktail[0].drinkName,
                                    drinkThumb:
                                        data.randomCocktail[0].drinkThumb,
                                    instructions:
                                        data.randomCocktail[0].instructions,
                                    category: data.randomCocktail[0].category,
                                    glass: data.randomCocktail[0].glass),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                error: (e, stack) => Text('$e'),
                loading: () => const CircularProgressIndicator());
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomFab(
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
                  onPressed: () {
                    setState(() {
                      setState(() {
                        isButtonOneSelected = false;
                        isButtonTwoSelected = true;
                      });
                    });
                  },
                  buttonText: "My Favorites",
                  isButtonSelected: isButtonTwoSelected),
            ],
          ),
        ),
      ),
    );
  }
}
