import 'package:flutter/material.dart';
import 'package:presentation/Library/images_utils/images_utils.dart';
import 'package:presentation/base/bloc_screen.dart';
import 'package:presentation/colors_application/colors_application.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/ui/splash_screen/bloc/splash_bloc.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  static const _routeName = '/SplashWidget';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const SplashWidget(),
        showSlideAnim: true,
        showBottomBar: false,
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
                    ColorsApplication.primaryColor,
                    ColorsApplication.primaryColorEnd,
                  ],
                ),
              ),
              child: Center(
                child: Image.asset(
                  ImagesUtils.imageSplash,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
