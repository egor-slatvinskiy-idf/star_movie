import 'package:domain/model/firebase_user_email.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/preferences_local_repository.dart';
import 'package:domain/use_case/sample_use_case/use_case_out.dart';

class LoginFacebookUseCase extends UseCaseOut<Future<bool>> {
  final AuthRepository authRepository;
  final PreferencesLocalRepository preferences;

  LoginFacebookUseCase(
    this.authRepository,
    this.preferences,
  );

  @override
  Future<bool> call() async {
    final UserEmailPass? user = await authRepository.loginWithFacebook();
    if (user == null) return false;
    final isAbleToLogin = await authRepository.checkUserExists(user);
    if (isAbleToLogin) await preferences.saveLoggedUser(user);
    return isAbleToLogin;
  }
}
