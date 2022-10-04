import 'package:domain/model/firebase_user_email.dart';

abstract class AuthRepository {
  Future<List<UserEmailPass>> fetchUsers();

  Future<UserEmailPass?> loginWithFacebook();

  Future<UserEmailPass?> loginWithGoogle();
}
