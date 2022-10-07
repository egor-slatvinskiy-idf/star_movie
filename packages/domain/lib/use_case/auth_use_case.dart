import 'package:domain/model/firebase_user_email.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/preferences_local_repository.dart';
import 'package:domain/use_case/sample_use_case/use_case_in_out.dart';

class LoginEmailAndPassUseCase
    extends UseCaseInOut<UserEmailPass, Future<bool>> {
  final AuthRepository authRepository;
  final PreferencesLocalRepository preferences;

  LoginEmailAndPassUseCase(
    this.authRepository,
    this.preferences,
  );

  @override
  Future<bool> call(UserEmailPass user) async {
    final isAbleToLogin = await authRepository.userExistenceCheck(user);
    if (isAbleToLogin) await preferences.saveLoggedUser(user);
    return isAbleToLogin;
  }
}
