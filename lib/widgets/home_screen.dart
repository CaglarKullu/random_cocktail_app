import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:random_cocktail_app/widgets/logged_In_screen.dart';
import 'package:random_cocktail_app/widgets/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return LogedInScreen(title: "Random Cocktail App");
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Oops something went wrong"),
            );
          } else {
            return LogInScreen();
          }
        }),
      ),
    );
  }
}
