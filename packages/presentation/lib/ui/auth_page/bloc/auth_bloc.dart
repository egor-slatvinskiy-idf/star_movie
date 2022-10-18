import 'package:domain/model/firebase_user_email.dart';
import 'package:domain/model/validate_result_model.dart';
import 'package:domain/use_case/auth_use_case.dart';
import 'package:domain/use_case/log_analytics_button_use_case.dart';
import 'package:domain/use_case/login_facebook_use_case.dart';
import 'package:domain/use_case/login_google_use_case.dart';
import 'package:domain/use_case/login_validator_use_case.dart';
import 'package:flutter/material.dart';
import 'package:presentation/base/bloc.dart';
import 'package:presentation/generated/l10n.dart';
import 'package:presentation/library/const/error_message.dart';
import 'package:presentation/library/const/event_name.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/ui/auth_page/bloc/auth_tile.dart';
import 'package:presentation/ui/profile_page/profile_widget.dart';

abstract class AuthBloc extends Bloc<BaseArguments, AuthTile> {
  factory AuthBloc(
    LoginEmailAndPassUseCase authUseCase,
    LoginGoogleUseCase loginGoogleUseCase,
    LoginFacebookUseCase loginFacebookUseCase,
    LogAnalyticsButtonUseCase analyticsUseCase,
    LogValidatorUseCase validatorUseCase,
  ) =>
      AuthBlocImpl(
        authUseCase: authUseCase,
        loginGoogleUseCase: loginGoogleUseCase,
        loginFacebookUseCase: loginFacebookUseCase,
        logButtonUseCase: analyticsUseCase,
        validatorUseCase: validatorUseCase,
      );

  TextEditingController get textLoginController;

  TextEditingController get textPasswordController;

  Future<void> auth();

  Future<void> authFacebook();

  Future<void> authGoogle();

  GlobalKey<FormState> get formKey;

  String? validatorLogin(String? login);

  String? validatorPassword(String? password);
}

class AuthBlocImpl extends BlocImpl<BaseArguments, AuthTile>
    implements AuthBloc {
  var _tile = AuthTile.init();
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final LoginGoogleUseCase loginGoogleUseCase;
  final LoginFacebookUseCase loginFacebookUseCase;
  final LoginEmailAndPassUseCase authUseCase;
  final LogAnalyticsButtonUseCase logButtonUseCase;
  final LogValidatorUseCase validatorUseCase;

  @override
  GlobalKey<FormState> get formKey => _formKey;

  @override
  TextEditingController get textLoginController => _loginController;

  @override
  TextEditingController get textPasswordController => _passwordController;

  UserEmailPass get _enteredUser => UserEmailPass(
        _loginController.text,
        _passwordController.text,
      );

  AuthBlocImpl({
    required this.validatorUseCase,
    required this.authUseCase,
    required this.logButtonUseCase,
    required this.loginGoogleUseCase,
    required this.loginFacebookUseCase,
  });

  @override
  void initState() {
    super.initState();
    _loginController.addListener(() {
      _tile = _tile.copyWith(
        errorMessageLogin: null,
        errorMessagePassword: _tile.errorMessagePassword,
      );
      _formKey.currentState?.validate();
    });
    _passwordController.addListener(() {
      _tile = _tile.copyWith(
        errorMessagePassword: null,
        errorMessageLogin: _tile.errorMessageLogin,
      );
      _formKey.currentState?.validate();
    });
  }

  @override
  String? validatorLogin(String? login) => _tile.errorMessageLogin;

  @override
  String? validatorPassword(String? password) => _tile.errorMessagePassword;

  @override
  Future<void> auth() async {
    handleData(isLoading: true);
    await logButtonUseCase(EventName.loginClick);
    validationLogin();
    validationPassword();
    if (_formKey.currentState?.validate() ?? false) {
      _tryLogin(await authUseCase(_enteredUser));
    }
    handleData(isLoading: false);
  }

  @override
  Future<void> authFacebook() async {
    await logButtonUseCase(EventName.facebookClick);
    _tryLogin(await loginFacebookUseCase());
  }

  @override
  Future<void> authGoogle() async {
    await logButtonUseCase(EventName.googleClick);
    _tryLogin(await loginGoogleUseCase());
  }

  _tryLogin(bool isAbleToLogin) {
    if (isAbleToLogin) {
      appNavigator.push(ProfileWidget.page());
      return;
    }
    _tile = _tile.copyWith(
      errorMessageLogin: ErrorMessage.failLogging,
      errorMessagePassword: ErrorMessage.failLogging,
    );
    _formKey.currentState?.validate();
    handleData(
      tile: _tile,
      isLoading: false,
    );
  }

  void validationLogin() {
    final validationResult = validatorUseCase(_enteredUser);
    switch (validationResult.validationLogin) {
      case ValidateResultModel.loginIsRequired:
        _tile = _tile.copyWith(
          errorMessageLogin: S.current.loginIsRequired,
          errorMessagePassword: _tile.errorMessagePassword,
        );
        break;
      case ValidateResultModel.invalidLogin:
        _tile = _tile.copyWith(
          errorMessageLogin: S.current.loginRegex,
          errorMessagePassword: _tile.errorMessagePassword,
        );
        break;
      case null:
        _tile = _tile.copyWith(
          errorMessageLogin: null,
          errorMessagePassword: _tile.errorMessagePassword,
        );
        break;
    }
  }

  void validationPassword() {
    final validationResult = validatorUseCase(_enteredUser);
    switch (validationResult.validationPassword) {
      case ValidateResultModel.passwordIsRequired:
        _tile = _tile.copyWith(
          errorMessagePassword: S.current.passwordIsRequired,
          errorMessageLogin: _tile.errorMessageLogin,
        );
        break;
      case ValidateResultModel.invalidPassword:
        _tile = _tile.copyWith(
          errorMessagePassword: S.current.passwordRegex,
          errorMessageLogin: _tile.errorMessageLogin,
        );
        break;
      case null:
        _tile = _tile.copyWith(
          errorMessagePassword: null,
          errorMessageLogin: _tile.errorMessageLogin,
        );
        break;
    }
  }
}
