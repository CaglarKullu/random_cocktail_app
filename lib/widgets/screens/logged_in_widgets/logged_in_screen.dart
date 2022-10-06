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

    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Center(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return drink.when(
                data: ((data) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: SingleChildScrollView(
                          child: CocktailDetail(
                              ingredientList: [
                                Ingredient(
                                    ingredientName:
                                        data.randomCocktail[0].strIngredient1,
                                    ingredientmeasure:
                                        data.randomCocktail[0].strMeasure1),
                                Ingredient(
                                    ingredientName:
                                        data.randomCocktail[0].strIngredient2,
                                    ingredientmeasure:
                                        data.randomCocktail[0].strMeasure2),
                                Ingredient(
                                    ingredientName:
                                        data.randomCocktail[0].strIngredient3,
                                    ingredientmeasure:
                                        data.randomCocktail[0].strMeasure3),
                                Ingredient(
                                    ingredientName:
                                        data.randomCocktail[0].strIngredient4,
                                    ingredientmeasure:
                                        data.randomCocktail[0].strMeasure4),
                                Ingredient(
                                    ingredientName:
                                        data.randomCocktail[0].strIngredient5,
                                    ingredientmeasure:
                                        data.randomCocktail[0].strMeasure5),
                                Ingredient(
                                    ingredientName:
                                        data.randomCocktail[0].strIngredient6,
                                    ingredientmeasure:
                                        data.randomCocktail[0].strMeasure6),
                                Ingredient(
                                    ingredientName:
                                        data.randomCocktail[0].strIngredient7,
                                    ingredientmeasure:
                                        data.randomCocktail[0].strMeasure7),
                                Ingredient(
                                    ingredientName:
                                        data.randomCocktail[0].strIngredient8,
                                    ingredientmeasure:
                                        data.randomCocktail[0].strMeasure8),
                                Ingredient(
                                    ingredientName:
                                        data.randomCocktail[0].strIngredient9,
                                    ingredientmeasure:
                                        data.randomCocktail[0].strMeasure9),
                                Ingredient(
                                    ingredientName:
                                        data.randomCocktail[0].strIngredient10,
                                    ingredientmeasure:
                                        data.randomCocktail[0].strMeasure10),
                                Ingredient(
                                    ingredientName:
                                        data.randomCocktail[0].strIngredient11,
                                    ingredientmeasure:
                                        data.randomCocktail[0].strMeasure11),
                                Ingredient(
                                    ingredientName:
                                        data.randomCocktail[0].strIngredient12,
                                    ingredientmeasure:
                                        data.randomCocktail[0].strMeasure12),
                                Ingredient(
                                    ingredientName:
                                        data.randomCocktail[0].strIngredient13,
                                    ingredientmeasure:
                                        data.randomCocktail[0].strMeasure13),
                                Ingredient(
                                    ingredientName:
                                        data.randomCocktail[0].strIngredient14,
                                    ingredientmeasure:
                                        data.randomCocktail[0].strMeasure14),
                                Ingredient(
                                    ingredientName:
                                        data.randomCocktail[0].strIngredient15,
                                    ingredientmeasure:
                                        data.randomCocktail[0].strMeasure15),
                              ],
                              drinkName: data.randomCocktail[0].drinkName,
                              drinkThumb: data.randomCocktail[0].drinkThumb,
                              instructions: data.randomCocktail[0].instructions,
                              category: data.randomCocktail[0].category,
                              glass: data.randomCocktail[0].glass),
                        ),
                      ),
                    ],
                  );
                }),
                error: (e, stack) => Text('$e'),
                loading: () => const CircularProgressIndicator());
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

                      //ref.read(addUser(user!.uid));
                      //ref.read(createUser);
                      dbHelp
                          .whenData((value) => value.addFavorite(RandomCocktail(
                                drinkName: "drinkName",
                                drinkThumb: "drinkThumb",
                                instructions: "instructions",
                                category: "category",
                                glass: "glass",
                                idDrink: 0,
                              )));
                    });
                  });
                },
                buttonText: "My Favorites",
                isButtonSelected: isButtonTwoSelected),
          ],
        ),
      ),
    );
  }
}
