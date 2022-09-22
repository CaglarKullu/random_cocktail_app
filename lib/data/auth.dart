import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:random_cocktail_app/models/user.dart';

class AuthService extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignInAccount? _googleUser;
  GoogleSignInAccount get googleUser => _googleUser!;

  // create user obj based on firebase user
  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<AppUser?> get user {
    return _auth
        .authStateChanges() //.map((User? user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

// sign in anon
  Future signInAnon() async {
    try {
      final userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          break;
        default:
      }
    }
    notifyListeners();
  }

  // sign in Google Sign In
  Future googleLogIn() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _googleUser = googleUser;
    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _auth.signInWithCredential(credential);
    notifyListeners();
  }

  //logOut
  Future googleLogout() async {
    await googleSignIn.disconnect();
    _auth.signOut();
  }

  Future anonLogout() async {
    _auth.signOut();
  }
}

final authProvider = ChangeNotifierProvider<AuthService>(
  (ref) => AuthService(),
);
