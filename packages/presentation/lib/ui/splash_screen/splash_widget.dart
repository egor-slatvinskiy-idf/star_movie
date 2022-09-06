import 'package:flutter/material.dart';
import 'package:presentation/app_colors/app_colors.dart';
import 'package:presentation/base/bloc_screen.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/ui/splash_screen/bloc/splash_bloc.dart';

const image = 'packages/presentation/images/Frame.png';

class SplashWidget extends StatefulWidget {
  const SplashWidget({Key? key}) : super(key: key);

  static const _routeName = '/SplashWidget';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const SplashWidget(),
        showSlideAnim: true,
      );

  @override
  State createState() => _SplashWidgetState();
}

class _SplashWidgetState extends BlocScreenState<SplashWidget, SplashBloc> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.dataStream,
      builder: (_, snapshot) {
        return Scaffold(
          body: Center(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(229, 25, 55, 1),
                    Color.fromRGBO(219, 82, 82, 1),
                  ],
                ),
              ),
              child: Center(
                child: Image.asset(
                  image,
                  // fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
