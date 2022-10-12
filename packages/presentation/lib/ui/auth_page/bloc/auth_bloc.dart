import 'package:domain/model/firebase_analytics_model.dart';
import 'package:domain/model/firebase_user_email.dart';
import 'package:domain/use_case/analytics_use_case.dart';
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
    AnalyticsUseCase analyticsUseCase,
  ) =>
      AuthBlocImpl(
        authUseCase: authUseCase,
        loginGoogleUseCase: loginGoogleUseCase,
        loginFacebookUseCase: loginFacebookUseCase,
        analytics: analyticsUseCase,
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
  final AnalyticsUseCase analytics;

  @override
  TextEditingController get textLoginController => _loginController;

  @override
  TextEditingController get textPasswordController => _passwordController;

  AuthBlocImpl({
    required this.authUseCase,
    required this.analytics,
    required this.loginGoogleUseCase,
    required this.loginFacebookUseCase,
  });

  @override
  Future<void> authFacebook() async {
    final eventLog = FirebaseAnalyticsModel(eventName: EventName.facebookClick);
    await analytics(eventLog);
    await _tryLogin(await loginFacebookUseCase());
  }

  @override
  Future<void> authGoogle() async {
    final eventLog = FirebaseAnalyticsModel(eventName: EventName.googleClick);
    await analytics(eventLog);
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
    final eventLog = FirebaseAnalyticsModel(eventName: EventName.loginClick);
    await analytics(eventLog);
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
