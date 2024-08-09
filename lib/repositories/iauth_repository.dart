import 'package:random_cocktail_app/models/user_model.dart';

abstract class IAuthRepository {
  Future<void> anonSignIn();
  Future<UserModel?> signIn();
  Future<void> logout();
  UserModel? getCurrentUser();
}
