import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:random_cocktail_app/consts/text_style.dart';
import 'package:random_cocktail_app/data/ad_state.dart';
import 'package:random_cocktail_app/models/ingredients.dart';

class CocktailDetail extends ConsumerStatefulWidget {
  final String drinkName;
  final int drinkId;
  final String drinkThumb;
  final String instructions;
  final String category;
  final String glass;
  final List<Ingredient> ingredientList;
  final VoidCallback? onPressed;

  const CocktailDetail(
      {Key? key,
      required this.onPressed,
      required this.drinkId,
      required this.ingredientList,
      required this.drinkName,
      required this.drinkThumb,
      required this.instructions,
      required this.category,
      required this.glass})
      : super(key: key);

  @override
  ConsumerState<CocktailDetail> createState() => _CocktailDetailState();
}

class _CocktailDetailState extends ConsumerState<CocktailDetail> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final addState = ref.watch(adStateProvider);

    addState.initialization?.then((status) {
      setState(() {
        banner = BannerAd(
            size: AdSize.banner,
            adUnitId: addState.bannerAdUnitID,
            listener: addState.adListener,
            request: const AdRequest())
          ..load();
      });
    });
  }

  BannerAd? banner;
  @override
  Widget build(BuildContext context) {
    List<Ingredient> ingredientList = widget.ingredientList;
    ingredientList.removeWhere((element) => element.ingredientName == null);

    return Padding(
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
                  icon: const Icon(Icons.favorite_border_rounded),
                  onPressed: widget.onPressed,
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
          if (banner == null)
            const SizedBox(
              height: 60,
            )
          else
            SizedBox(
              height: 60,
              child: AdWidget(ad: banner!),
            ),
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
    );
  }
}
