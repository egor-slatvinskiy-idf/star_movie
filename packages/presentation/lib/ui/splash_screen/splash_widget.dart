import 'package:flutter/material.dart';
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
  }
}
