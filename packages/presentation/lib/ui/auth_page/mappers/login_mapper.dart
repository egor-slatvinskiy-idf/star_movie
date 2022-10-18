import 'package:domain/base/mappers/base_mappers/mapper_base.dart';
import 'package:domain/model/validate_model.dart';
import 'package:domain/model/validate_result_model.dart';
import 'package:presentation/generated/l10n.dart';

class MapperLogin extends Mapper<LoginValidationModel, LoginValidationModel?> {
  @override
  LoginValidationModel call(LoginValidationModel params) =>
      LoginValidationModel(
        validationLogin: mapperValidation(params.validationLogin),
        validationPassword: mapperValidation(params.validationPassword),
      );

  String? mapperValidation(String? model) {
    switch (model) {
      case ValidateResultModel.passwordIsRequired:
        return S.current.passwordIsRequired;
      case ValidateResultModel.invalidPassword:
        return S.current.passwordRegex;
      case ValidateResultModel.loginIsRequired:
        return S.current.loginIsRequired;
      case ValidateResultModel.invalidLogin:
        return S.current.loginRegex;
      case null:
        return null;
    }
    return null;
  }
}
