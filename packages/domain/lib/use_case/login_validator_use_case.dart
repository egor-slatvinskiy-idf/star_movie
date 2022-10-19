import 'package:domain/model/firebase_user_email.dart';
import 'package:domain/model/validate_model.dart';
import 'package:domain/model/validate_result_model.dart';
import 'package:domain/use_case/sample_use_case/use_case_in_out.dart';

const _minLengthLogin = 8;
const _patternRegexPassword = '^[a-zA-Z0-9]{7,}\$';

class LogValidatorUseCase
    extends UseCaseInOut<UserEmailPass, LoginValidationModel> {
  @override
  LoginValidationModel call(UserEmailPass params) {
    return LoginValidationModel(
      validationLogin: validationLogin(params.login),
      validationPassword: validationPassword(params.password),
    );
  }

  String? validationLogin(String enteredLogin) {
    if (enteredLogin.isEmpty) {
      return ValidateResultModel.loginIsRequired;
    } else if (enteredLogin.length < _minLengthLogin) {
      return ValidateResultModel.invalidLogin;
    } else {
      return null;
    }
  }

  String? validationPassword(String enteredPassword) {
    if (enteredPassword.isEmpty) {
      return ValidateResultModel.passwordIsRequired;
    } else if (!RegExp(_patternRegexPassword).hasMatch(enteredPassword)) {
      return ValidateResultModel.invalidPassword;
    } else {
      return null;
    }
  }
}
