import 'package:domain/model/firebase_user_email.dart';

abstract class AuthRepository {
  Future<UserEmailPass?> loginWithFacebook();

  Future<UserEmailPass?> loginWithGoogle();

  Future<bool> userExistenceCheck(UserEmailPass user);
}
