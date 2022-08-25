import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_cocktail_app/api_service/random_cocktail_api.dart';
import 'package:random_cocktail_app/consts/color.dart';
import 'package:random_cocktail_app/models/ingredients.dart';
import 'package:random_cocktail_app/widgets/cocktail_detail.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _counter = 0;
  bool isB52 = false;
  _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(widget.title),
      ),
      body: Center(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final drink = ref.watch(randomDrink);
            return drink.when(
                data: ((data) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                          onPressed: (() {
                            setState(() {
                              _incrementCounter();
                              ref.refresh(randomDrink);
                              if (_counter == 3) {
                                isB52 = true;
                              }
                            });
                          }),
                          child:
                              const Text("Bartender bring me random drink!")),
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
    );
  }
}
