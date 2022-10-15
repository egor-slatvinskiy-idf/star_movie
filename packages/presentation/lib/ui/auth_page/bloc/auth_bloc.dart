import 'package:domain/model/firebase_analytics_model.dart';
import 'package:domain/model/firebase_user_email.dart';
import 'package:domain/use_case/analytics_use_case.dart';
import 'package:domain/use_case/auth_use_case.dart';
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
    AnalyticsUseCase analyticsUseCase,
    ValidatorUseCase validatorUseCase,
  ) =>
      AuthBlocImpl(
        authUseCase: authUseCase,
        loginGoogleUseCase: loginGoogleUseCase,
        loginFacebookUseCase: loginFacebookUseCase,
        analytics: analyticsUseCase,
        validatorUseCase: validatorUseCase,
      );

  TextEditingController get textLoginController;

  TextEditingController get textPasswordController;

  Future<void> auth();

  Future<void> authFacebook();

  Future<void> authGoogle();

  GlobalKey<FormState> get formKey;

  String? validatorLogin(BuildContext context);

  String? validatorPassword(BuildContext context);
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
  final ValidatorUseCase validatorUseCase;
  final AnalyticsUseCase analytics;

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
    required this.analytics,
    required this.loginGoogleUseCase,
    required this.loginFacebookUseCase,
  });

  @override
  String? validatorLogin(BuildContext context) {
    final useCase = validatorUseCase(_enteredUser);
    if (useCase.validIsEmptyLogin) {
      return S.of(context).loginIsRequired;
    } else if (useCase.validRegexLogin) {
      return S.of(context).loginRegex;
    } else {
      return null;
    }
  }

  @override
  String? validatorPassword(BuildContext context) {
    final useCase = validatorUseCase(_enteredUser);
    if (useCase.validIsEmptyPassword) {
      return S.of(context).passwordIsRequired;
    } else if (useCase.validRegexPassword) {
      return S.of(context).passwordRegex;
    } else {
      return null;
    }
  }

  @override
  Future<void> auth() async {
    handleData(tile: _tile, isLoading: true);
    final eventLog = FirebaseAnalyticsModel(eventName: EventName.loginClick);
    await analytics(eventLog);
    if (formKey.currentState?.validate() ?? false) {
      _tryLogin(await authUseCase(_enteredUser));
    }
    handleData(isLoading: false);
  }

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
