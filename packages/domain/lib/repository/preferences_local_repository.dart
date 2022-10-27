import 'package:domain/model/firebase_user_email.dart';

abstract class PreferencesLocalRepository {
  Future<void> saveLoggedUser(UserEmailPass user);
}
