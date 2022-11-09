import 'dart:io';

import 'package:domain/use_case/splash_duration_use_case.dart';
import 'package:domain/use_case/check_version_use_case.dart';
import 'package:presentation/base/bloc.dart';
import 'package:presentation/generated/l10n.dart';
import 'package:presentation/library/const/links.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/ui/movie_page/movie_widget.dart';
import 'package:presentation/ui/splash_screen/bloc/splash_tile.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class SplashBloc extends Bloc<BaseArguments, SplashTile> {
  factory SplashBloc(
    SplashDurationUseCase durationUseCase,
    CheckVersionUseCase versionUseCase,
  ) =>
      SplashBlocImpl(
        durationUseCase,
        versionUseCase,
      );

  Future<void> updateTap();
}

class SplashBlocImpl extends BlocImpl<BaseArguments, SplashTile>
    implements SplashBloc {
  var _tile = SplashTile.init();
  final SplashDurationUseCase _durationUseCase;
  final CheckVersionUseCase _versionUseCase;

  SplashBlocImpl(
    this._durationUseCase,
    this._versionUseCase,
  );

  @override
  void initState() async {
    super.initState();
    final versionResult = await checkVersion();
    nextScreen(versionResult);
  }

  Future<String> checkVersion() async {
    final checkResult = await _versionUseCase();
    switch (checkResult) {
      case TypeNotificationVersion.outdatedVersion:
        _tile = _tile.copyWith(checkResult: S.current.outdatedVersionResult);
        handleData(tile: _tile);
        break;
      case TypeNotificationVersion.suitableVersion:
        _tile = _tile.copyWith(checkResult: S.current.suitableVersionResult);
        handleData(tile: _tile);
        return S.current.suitableVersionResult;
      case null:
        handleData(tile: _tile);
        return S.current.actualVersionResult;
    }
    return S.current.emptyString;
  }

  @override
  Future<void> updateTap() {
    if (Platform.isAndroid) {
      return launchUrl(Uri.parse(Links.androidMarketTelegram));
    } else if (Platform.isMacOS) {
      return launchUrl(Uri.parse(Links.MacOSMarketTelegram));
    } else {
      return launchUrl(Uri.parse(Links.IOSMarketTelegram));
    }
  }

  Future<void> nextScreen(String versionResult) async {
    await _durationUseCase();
    if (versionResult.isNotEmpty) {
      appNavigator.popAndPush(
        MovieWidget.page(),
      );
    }
  }
}
