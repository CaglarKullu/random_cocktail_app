import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_cocktail_app/models/random_cocktail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDB extends ChangeNotifier {
  Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDB();
    }
    return _db;
  }

  Future<Database> initDB() async {
    String dbPath = join(await getDatabasesPath(), "cocktaildb_v2.db");
    var sourdoughDB =
        await openDatabase(dbPath, version: 1, onCreate: createDb);
    return sourdoughDB;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE cocktails (ID INTEGER PRIMARY KEY, idDrink TEXT, strDrink TEXT, strCategory TEXT, strInstructions TEXT, strGlass TEXT, strDrinkThumb TEXT, strIngredient1 TEXT, strIngredient2 TEXT, strIngredient3 TEXT, strIngredient4 TEXT, strIngredient5 TEXT, strIngredient6 TEXT, strIngredient7 TEXT, strIngredient8 TEXT, strIngredient9 TEXT, strIngredient10 TEXT, strIngredient11 TEXT, strIngredient12 TEXT, strIngredient13 TEXT, strIngredient14 TEXT, strIngredient15 TEXT, strMeasure1 TEXT, strMeasure2 TEXT, strMeasure3 TEXT, strMeasure4 TEXT, strMeasure5 TEXT, strMeasure6 TEXT, strMeasure7 TEXT, strMeasure8 TEXT, strMeasure9 TEXT, strMeasure10 TEXT, strMeasure11 TEXT, strMeasure12 TEXT, strMeasure13 TEXT, strMeasure14 TEXT, strMeasure15 TEXT)");
  }

  FutureOr<List<RandomCocktail>> getAllCocktails() async {
    Database? db = await this.db;
    var result = await db!.query("cocktails");
    return List.generate(result.length, (i) {
      return RandomCocktail.fromJson(result[i]);
    });
  }

  Future insertCocktail(RandomCocktail cocktail) async {
    Database? db = await this.db;
    var result = await db!.insert("cocktails", cocktail.toJson());
    return result;
  }

  Future<int> deleteCocktail(String idDrink) async {
    Database? db = await this.db;
    var result =
        await db!.rawDelete("DELETE FROM cocktails where idDrink = $idDrink");
    return result;
  }
}

final localDBProvider = Provider(((ref) => LocalDB()));
final localCocktailListProvider =
    FutureProvider((ref) => LocalDB().getAllCocktails());
