import 'package:flutter/material.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.drinkName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.height * 0.75,
            child: FittedBox(child: Image.network(widget.drinkThumb))),
        Text(widget.category),
        Text(widget.glass),
        Text(widget.instructions),
        ListView.builder(
            shrinkWrap: true,
            itemCount: widget.ingredientList.length,
            itemBuilder: ((context, index) {
              return ListTile(
                leading:
                    Text(widget.ingredientList[index].ingredientName ?? ""),
                trailing:
                    Text(widget.ingredientList[index].ingredientmeasure ?? ""),
              );
            }))
      ],
    );
  }
}
