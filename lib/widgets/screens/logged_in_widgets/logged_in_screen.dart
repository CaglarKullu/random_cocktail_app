import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                                    onPressed: (() {
                                      dbHelp.whenData((value) =>
                                          value.addFavorite(RandomCocktail(
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
                                            strIngredient10:
                                                info.strIngredient10,
                                            strIngredient11:
                                                info.strIngredient11,
                                            strIngredient12:
                                                info.strIngredient12,
                                            strIngredient13:
                                                info.strIngredient13,
                                            strIngredient14:
                                                info.strIngredient14,
                                            strIngredient15:
                                                info.strIngredient15,
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
                                    ingredientList: [
                                      Ingredient(
                                          ingredientName: info.strIngredient1,
                                          ingredientmeasure: data
                                              .randomCocktail[0].strMeasure1),
                                      Ingredient(
                                          ingredientName: info.strIngredient2,
                                          ingredientmeasure: info.strMeasure2),
                                      Ingredient(
                                          ingredientName: info.strIngredient3,
                                          ingredientmeasure: info.strMeasure3),
                                      Ingredient(
                                          ingredientName: info.strIngredient4,
                                          ingredientmeasure: info.strMeasure4),
                                      Ingredient(
                                          ingredientName: info.strIngredient5,
                                          ingredientmeasure: data
                                              .randomCocktail[0].strMeasure5),
                                      Ingredient(
                                          ingredientName: info.strIngredient6,
                                          ingredientmeasure: info.strMeasure6),
                                      Ingredient(
                                          ingredientName: info.strIngredient7,
                                          ingredientmeasure: info.strMeasure7),
                                      Ingredient(
                                          ingredientName: info.strIngredient8,
                                          ingredientmeasure: info.strMeasure8),
                                      Ingredient(
                                          ingredientName: info.strIngredient9,
                                          ingredientmeasure: info.strMeasure9),
                                      Ingredient(
                                          ingredientName: info.strIngredient10,
                                          ingredientmeasure: info.strMeasure10),
                                      Ingredient(
                                          ingredientName: info.strIngredient11,
                                          ingredientmeasure: info.strMeasure11),
                                      Ingredient(
                                          ingredientName: info.strIngredient12,
                                          ingredientmeasure: info.strMeasure12),
                                      Ingredient(
                                          ingredientName: info.strIngredient13,
                                          ingredientmeasure: info.strMeasure13),
                                      Ingredient(
                                          ingredientName: info.strIngredient14,
                                          ingredientmeasure: info.strMeasure14),
                                      Ingredient(
                                          ingredientName: info.strIngredient15,
                                          ingredientmeasure: info.strMeasure15),
                                    ],
                                    drinkId: info.idDrink,
                                    drinkName: info.drinkName,
                                    drinkThumb: info.drinkThumb,
                                    instructions: info.instructions,
                                    category: info.category,
                                    glass: info.glass),
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
