import 'package:presentation/base/bloc.dart';
import 'package:presentation/ui/home_page/home_widget.dart';

abstract class SplashBloc extends Bloc {
  factory SplashBloc() => SplashBlocImpl();
}

class SplashBlocImpl extends BlocImpl implements SplashBloc {
  SplashBlocImpl();

  @override
  void initState() {
    super.initState();
    nextScreen();
  }

  Future<void> nextScreen() async {
    await Future.delayed(
      const Duration(seconds: 3),
      () => appNavigator.popAndPush(
        HomeWidget.page(),
      ),
    );
  }
}
