import 'package:domain/model/firebase_user_email.dart';
import 'package:domain/use_case/log_analytics_button_use_case.dart';
import 'package:domain/use_case/auth_use_case.dart';
import 'package:domain/use_case/login_facebook_use_case.dart';
import 'package:domain/use_case/login_google_use_case.dart';
import 'package:flutter/material.dart';
import 'package:presentation/base/bloc.dart';
import 'package:presentation/library/const/error_message.dart';
import 'package:presentation/library/const/event_name.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/ui/auth_page/bloc/auth_tile.dart';
import 'package:presentation/ui/auth_page/bloc/validator/validator.dart';
import 'package:presentation/ui/profile_page/profile_widget.dart';

abstract class AuthBloc extends Bloc<BaseArguments, AuthTile> {
  factory AuthBloc(
    LoginEmailAndPassUseCase authUseCase,
    LoginGoogleUseCase loginGoogleUseCase,
    LoginFacebookUseCase loginFacebookUseCase,
    LogAnalyticsButtonUseCase analyticsUseCase,
  ) =>
      AuthBlocImpl(
        authUseCase: authUseCase,
        loginGoogleUseCase: loginGoogleUseCase,
        loginFacebookUseCase: loginFacebookUseCase,
        logButtonUseCase: analyticsUseCase,
      );

  TextEditingController get textLoginController;

  TextEditingController get textPasswordController;

  Future<void> auth();

  Future<void> authFacebook();

  Future<void> authGoogle();
}

class AuthBlocImpl extends BlocImpl<BaseArguments, AuthTile>
    implements AuthBloc {
  var _tile = AuthTile.init();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final LoginGoogleUseCase loginGoogleUseCase;
  final LoginFacebookUseCase loginFacebookUseCase;
  final LoginEmailAndPassUseCase authUseCase;
  final LogAnalyticsButtonUseCase logButtonUseCase;

  @override
  TextEditingController get textLoginController => _loginController;

  @override
  TextEditingController get textPasswordController => _passwordController;

  AuthBlocImpl({
    required this.authUseCase,
    required this.logButtonUseCase,
    required this.loginGoogleUseCase,
    required this.loginFacebookUseCase,
  });

  @override
  Future<void> authFacebook() async {
    await logButtonUseCase(EventName.facebookClick);
    await _tryLogin(await loginFacebookUseCase());
  }

  @override
  Future<void> authGoogle() async {
    await logButtonUseCase(EventName.googleClick);
    _tryLogin(await loginGoogleUseCase());
  }

  @override
  Future<void> auth() async {
    final login = _loginController.text;
    final password = _passwordController.text;
    handleData(tile: _tile, isLoading: false);
    if (Validator(login, password).isValid()) {
      handleData(
          tile: _tile.copyWith(errorMessage: ErrorMessage.fillLogOrPass));
      return;
    }
    handleData(isLoading: true);
    await logButtonUseCase(EventName.loginClick);
    final UserEmailPass user = UserEmailPass(login, password);
    _tryLogin(await authUseCase(user));
    handleData(isLoading: false);
  }

  _tryLogin(bool isAbleToLogin) {
    if (isAbleToLogin) {
      appNavigator.push(ProfileWidget.page());
      return;
    }
    _tile = _tile.copyWith(errorMessage: ErrorMessage.failLogging);
    handleData(
      tile: _tile,
      isLoading: false,
    );
  }
}
