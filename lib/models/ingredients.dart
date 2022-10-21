import 'package:cloud_firestore/cloud_firestore.dart';

class Ingredient {
  String? ingredientName;
  String? ingredientmeasure;
  Ingredient({required this.ingredientName, required this.ingredientmeasure});

  factory Ingredient.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Ingredient(
      ingredientName: data?['ingredientName'],
      ingredientmeasure: data?['ingredientmeasure'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (ingredientName != null) "ingredientName": ingredientName,
      if (ingredientmeasure != null) "ingredientmeasure": ingredientmeasure,
    };
  }
}
