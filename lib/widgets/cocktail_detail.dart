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
    List<Ingredient> ingredientList = widget.ingredientList;
    ingredientList.removeWhere((element) => element.ingredientName == null);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.drinkName,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
            children: const [
              Text(
                "Ingredient Name",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "Ingredient Measure",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: ingredientList.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  leading: Text(ingredientList[index].ingredientName!),
                  trailing: Text(ingredientList[index].ingredientmeasure ?? ""),
                );
              })),
          const Text(
            "Instructions",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.instructions,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}
