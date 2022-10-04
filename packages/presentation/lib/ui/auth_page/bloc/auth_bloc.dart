import 'package:domain/model/firebase_user_email.dart';
import 'package:domain/use_case/auth_use_case.dart';
import 'package:domain/use_case/login_facebook_use_case.dart';
import 'package:domain/use_case/login_google_use_case.dart';
import 'package:flutter/material.dart';
import 'package:presentation/base/bloc.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/services/firebase_analytics.dart';
import 'package:presentation/ui/auth_page/bloc/auth_tile.dart';
import 'package:presentation/ui/profile_page/profile_widget.dart';

abstract class AuthBloc extends Bloc<BaseArguments, AuthTile> {
  factory AuthBloc(
    LoginEmailAndPassUseCase authUseCase,
    Analytics analytics,
    LoginGoogleUseCase loginGoogleUseCase,
    LoginFacebookUseCase loginFacebookUseCase,
  ) =>
      AuthBlocImpl(
        authUseCase: authUseCase,
        analytics: analytics,
        loginGoogleUseCase: loginGoogleUseCase,
        loginFacebookUseCase: loginFacebookUseCase,
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
  final Analytics analytics;

  bool _isValid(String login, String password) =>
      login.isNotEmpty && password.isNotEmpty;

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
    analytics.analyticsFacebookClick();
    _tryLogin(await loginFacebookUseCase());
  }

  @override
  Future<void> authGoogle() async {
    analytics.analyticsGoogleClick();
    _tryLogin(await loginGoogleUseCase());
  }

  void _tryLogin(bool isAbleToLogin) {
    if (isAbleToLogin) {
      appNavigator.push(
        ProfileWidget.page(),
      );
      return;
    }
    handleData(
      tile: _tile.copyWith(errorMessage: 'Fail while logging'),
    );
  }

  @override
  Future<void> auth() async {
    final login = _loginController.text;
    final password = _passwordController.text;

    handleData(tile: _tile, isLoading: false);
    if (!_isValid(login, password)) {
      _tile = _tile.copyWith(errorMessage: 'Fill in your login or password');
      handleData(tile: _tile);
      return;
    }
    _tile = _tile.copyWith(errorMessage: '');
    handleData(tile: _tile, isLoading: true);
    final user = UserEmailPass(login, password);
    final request = await authUseCase(user);
    if (request) {
      appNavigator.push(
        ProfileWidget.page(),
      );
    }
    handleData(isLoading: false);
  }

  @override
  void initState() {
    super.initState();
  }
}
