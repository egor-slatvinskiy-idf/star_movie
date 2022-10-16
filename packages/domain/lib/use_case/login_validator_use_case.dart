import 'package:domain/model/firebase_user_email.dart';
import 'package:domain/model/validate_model.dart';
import 'package:domain/use_case/sample_use_case/use_case_in_out.dart';

const _patternRegexLogin = '^.{8,}\$';
const _patternRegexPassword = '^[^A-Z][^a-z]{6,}\$';

class ValidatorUseCase extends UseCaseInOut<UserEmailPass, ValidateModel> {
  @override
  ValidateModel call(UserEmailPass params) {
    return ValidateModel(
      validIsEmptyLogin: validIsEmptyLogin(params.login),
      validRegexLogin: validRegexLogin(params.login),
      validIsEmptyPassword: validIsEmptyPassword(params.password),
      validRegexPassword: validRegexPassword(params.password),
    );
  }

  bool validIsEmptyLogin(String enteredLogin) => enteredLogin.isEmpty;

  bool validRegexLogin(String enteredLogin) =>
      !RegExp(_patternRegexLogin).hasMatch(enteredLogin);

  bool validIsEmptyPassword(String enteredPassword) => enteredPassword.isEmpty;

  bool validRegexPassword(String enteredPassword) =>
      !RegExp(_patternRegexPassword).hasMatch(enteredPassword);
}
