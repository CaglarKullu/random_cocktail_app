import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_cocktail_app/widgets/screens/logged_in_widgets/logged_in_screen.dart';
import 'package:random_cocktail_app/widgets/screens/log_in_widgets/login_screen.dart';

import '../../view_models/Auth_View_Model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);
    log(authState.toString());
    if (authState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }

    if (authState.user == null) {
      return const LogInScreen();
    }

    if (authState.user != null) {
      return const LogedInScreen(
        title: '',
      );
    }

    if (authState.error != null) {
      return Center(
        child: Text("Error: ${authState.error}"),
      );
    }
    return const LogInScreen();
  }
}
