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
  final SplashDurationUseCase durationUseCase;

  SplashBlocImpl(
    this.durationUseCase,
  );

  @override
  void initState() {
    super.initState();
    nextScreen();
  }

  Future<void> nextScreen() async {
    await durationUseCase();
    appNavigator.popAndPush(
      HomeWidget.page(),
    );
  }
}
