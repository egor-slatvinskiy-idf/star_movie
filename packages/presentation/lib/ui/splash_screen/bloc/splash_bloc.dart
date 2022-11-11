import 'dart:io';

import 'package:domain/use_case/check_version_use_case.dart';
import 'package:presentation/base/bloc.dart';
import 'package:presentation/base/dialog_event.dart';
import 'package:presentation/generated/l10n.dart';
import 'package:presentation/library/const/links.dart';
import 'package:presentation/ui/movie_page/movie_widget.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class SplashBloc extends Bloc {
  factory SplashBloc(
    CheckVersionUseCase versionUseCase,
  ) =>
      SplashBlocImpl(
        versionUseCase,
      );

  Future<void> updateTap();

  void laterTap();
}

class SplashBlocImpl extends BlocImpl implements SplashBloc {
  final CheckVersionUseCase _versionUseCase;

  SplashBlocImpl(this._versionUseCase);

  @override
  void initState() async {
    super.initState();
    await checkVersion();
  }

  handleAlert({required String message}) {
    showAlert(event: VersionWindow(message: message));
  }

  Future<void> checkVersion() async {
    final checkResult = await _versionUseCase();
    switch (checkResult) {
      case TypeNotificationVersion.suitableVersion:
        handleAlert(message: S.current.showDialogSuitable);
        break;
      case TypeNotificationVersion.outdatedVersion:
        handleAlert(message: S.current.showDialogOutdated);
        break;
      case TypeNotificationVersion.actualVersion:
        nextScreen();
        break;
    }
  }

  @override
  void laterTap() {
    appNavigator.popAndPush(MovieWidget.page());
  }

  @override
  Future<void> updateTap() {
    final uri = Platform.isAndroid
        ? Links.androidMarketTelegram
        : Platform.isMacOS
            ? Links.MacOSMarketTelegram
            : Links.IOSMarketTelegram;
    return launchUrl(Uri.parse(uri));
  }

  void nextScreen() {
    appNavigator.popAndPush(
      MovieWidget.page(),
    );
  }
}
