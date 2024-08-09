import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String? displayName;
  final String? email;
  final String? photoUrl;
  final bool? isAnonymous;

  UserModel({
    required this.uid,
    this.displayName,
    this.email,
    this.photoUrl,
    this.isAnonymous,
  });

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      displayName: user.displayName,
      email: user.email,
      photoUrl: user.photoURL,
      isAnonymous: user.isAnonymous,
    );
  }
  // to string

  @override
  String toString() {
    return 'UserModel(uid: $uid, displayName: $displayName, email: $email, photoUrl: $photoUrl), isAnonymous: $isAnonymous)';
  }
}
