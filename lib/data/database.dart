import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_cocktail_app/models/random_cocktail.dart';

class DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  void addFavorite(RandomCocktail cocktail) async {
    if (user!.uid ==
        FirebaseFirestore.instance.collection("users").doc(user!.uid).id) {
      final docRef = FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("myFavorites")
          .doc(cocktail.drinkName);

      final json = cocktail.toJson();
      await docRef.set(json);
    }
  }

  void removeFromFavorite(String cocktailName) async {
    if (user!.uid ==
        FirebaseFirestore.instance.collection("users").doc(user!.uid).id) {
      final docRef = FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("myFavorites")
          .doc(cocktailName)
          .delete()
          .then(
            (doc) => log("Document deleted"),
            onError: (e) => log("Error updating document $e"),
          );
      await docRef;
    } else {
      null;
    }

    // delete user from firebase
    void deleteUser() {
      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .delete()
          .then(
            (doc) => log("Document deleted"),
            onError: (e) => log("Error updating document $e"),
          )
          .onError((error, stackTrace) => log(error.toString()));
    }
  }

  Stream<List<RandomCocktail>> myCocktailList(String? userID) {
    final docRef = FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .collection("myFavorites")
        .snapshots()
        .map((doc) =>
            doc.docs.map((e) => RandomCocktail.fromJson(e.data())).toList());
    return docRef;
  }
}

final db = FutureProvider((ref) => DatabaseService());
final cocktailListProvider = StreamProvider.family.autoDispose(
    ((ref, String? userID) =>
        DatabaseService().myCocktailList(ref.watch(userProvider)?.uid)));
final userProvider = Provider(((ref) => DatabaseService().user));
