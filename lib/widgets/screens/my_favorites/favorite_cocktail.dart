import 'package:flutter/material.dart';
import 'package:random_cocktail_app/consts/text_style.dart';
import 'package:random_cocktail_app/models/ingredients.dart';

class FavoriteCocktail extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                        drinkName,
                        style: titleTextStyle,
                      ),
                    ),
                    IconButton(
                      iconSize: 30,
                      icon: const Icon(Icons.favorite_border_rounded),
                      onPressed: (() {}),
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
                  itemCount: ingredientList.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      leading: Text(
                        ingredientList[index].ingredientName!,
                        style: textStyle,
                      ),
                      trailing: Text(
                        ingredientList[index].ingredientmeasure ?? "",
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
                  instructions,
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
      ),
    ));
  }
}
