import 'dart:convert';
import 'dart:core';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:random_cocktail_app/models/random_cocktail.dart';

class ApiServices {
  Future<ListOfRandomCocktail> fetchRandomDrink() async {
    final response = await http.get(
        Uri.parse('http://www.thecocktaildb.com/api/json/v1/1/random.php'));

    if (response.statusCode == 200) {
      return ListOfRandomCocktail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load drink');
    }
  }

  Future<ListOfRandomCocktail> fetchB52() async {
    final response = await http.get(Uri.parse(
        'http://www.thecocktaildb.com/api/json/v1/1/search.php?s=B-52'));

    if (response.statusCode == 200) {
      return ListOfRandomCocktail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load drink');
    }
  }

  Future<ListOfRandomCocktail> fetchDrinkByID(int idDrink) async {
    final response = await http.get(Uri.parse(
        'http://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$idDrink'));

    if (response.statusCode == 200) {
      return ListOfRandomCocktail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load drink');
    }
  }
}

final fetchDrinkB52 = FutureProvider<ListOfRandomCocktail>((ref) async {
  return ApiServices().fetchB52();
});

final drinkProviderById = FutureProvider.family<ListOfRandomCocktail, int>(
    (ref, idDrink) => ApiServices().fetchDrinkByID(idDrink));

final randomDrink = FutureProvider<ListOfRandomCocktail>((ref) async {
  return ApiServices().fetchRandomDrink();
});
