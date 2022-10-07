import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_cocktail_app/models/random_cocktail.dart';

class DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  void addFavorite(RandomCocktail cocktail) async {
    final docRef = FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("myFavorites")
        .doc(cocktail.drinkName);

    final json = cocktail.toJson();
    await docRef.set(json);
  }

  void removeFromFavorite(RandomCocktail cocktail) async {
    final docRef = FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("myFavorites")
        .doc("Adam Sunrise")
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
    await docRef;
  }
}

final db = FutureProvider((ref) => DatabaseService());
