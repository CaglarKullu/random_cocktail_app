import 'package:flutter/material.dart';
import 'package:random_cocktail_app/consts/text_style.dart';
import 'package:random_cocktail_app/models/ingredients.dart';

class CocktailDetail extends StatefulWidget {
  final String drinkName;
  final String drinkThumb;
  final String instructions;
  final String category;
  final String glass;
  final List<Ingredient> ingredientList;
  const CocktailDetail(
      {Key? key,
      required this.ingredientList,
      required this.drinkName,
      required this.drinkThumb,
      required this.instructions,
      required this.category,
      required this.glass})
      : super(key: key);

  @override
  State<CocktailDetail> createState() => _CocktailDetailState();
}

class _CocktailDetailState extends State<CocktailDetail> {
  @override
  Widget build(BuildContext context) {
    List<Ingredient> ingredientList = widget.ingredientList;
    ingredientList.removeWhere((element) => element.ingredientName == null);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.drinkName,
            style: titleTextStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.height * 0.75,
              child: FittedBox(child: Image.network(widget.drinkThumb))),
          //Text(widget.category),
          //Text(widget.glass),
          Row(
            children: [
              Text(
                "Ingredients",
                style: titleTextStyle,
              ),
              const Spacer(),
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
          Text(
            "Instructions",
            style: titleTextStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.instructions,
            textAlign: TextAlign.justify,
            style: textStyle,
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}