import 'package:flutter/material.dart';
import 'package:presentation/app_colors/app_colors.dart';
import 'package:presentation/navigation/base_page.dart';

const image = 'packages/presentation/images/Frame.png';

class SplashWidget extends StatelessWidget {
  const SplashWidget({Key? key}) : super(key: key);

  static const _routeName = '/SplashScreen';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const SplashWidget(),
        showSlideAnim: true,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primaryColor,
                AppColors.primaryColorEnd,
              ],
            ),
          ),
          child: Center(
            child: Image.asset(
              image,
            ),
          ),
        ),
      ),
    );
  }
}
