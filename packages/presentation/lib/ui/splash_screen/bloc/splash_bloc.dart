import 'package:domain/use_case/splash_duration_use_case.dart';
import 'package:presentation/base/bloc.dart';
import 'package:presentation/ui/home_page/home_widget.dart';

abstract class SplashBloc extends Bloc {
  factory SplashBloc(
    SplashDurationUseCase durationUseCase,
  ) =>
      SplashBlocImpl(
        durationUseCase,
      );
}

class SplashBlocImpl extends BlocImpl implements SplashBloc {
  final SplashDurationUseCase _durationUseCase;

  SplashBlocImpl(
    this._durationUseCase,
  );

  @override
  void initState() {
    super.initState();
    nextScreen();
  }

  Future<void> nextScreen() async {
    await _durationUseCase();
    appNavigator.popAndPush(
      HomeWidget.page(),
    );
  }
}
