import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_cocktail_app/widgets/screens/logged_in_widgets/logged_in_screen.dart';
import 'package:random_cocktail_app/widgets/screens/log_in_widgets/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return const LogedInScreen(
              title: '',
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Oops something went wrong"),
            );
          } else {
            return const LogInScreen();
          }
        }),
      ),
    );
  }
}
