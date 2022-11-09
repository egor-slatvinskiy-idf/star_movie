import 'package:flutter/material.dart';
import 'package:presentation/base/bloc_screen.dart';
import 'package:presentation/base/tile_wrapper.dart';
import 'package:presentation/colors_application/colors_application.dart';
import 'package:presentation/generated/l10n.dart';
import 'package:presentation/library/images_utils/images_utils.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/ui/splash_screen/bloc/splash_bloc.dart';
import 'package:presentation/ui/splash_screen/bloc/splash_tile.dart';

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
  Future<void> showMyDialog(
    bool suitableVersion,
    String content,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(content),
          actions: [
            suitableVersion == true
                ? TextButton(
                    onPressed: Navigator.of(context).pop,
                    child: Text(S.of(context).later),
                  )
                : const SizedBox.shrink(),
            TextButton(
              onPressed: bloc.updateTap,
              child: Text(S.of(context).update),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TileWrapper<SplashTile>>(
      stream: bloc.dataStream,
      builder: (_, snapshot) {
        final data = snapshot.data;
        final splashTile = data?.data;
        if (splashTile?.checkResult == S.of(context).outdatedVersionResult) {
          Future.delayed(
            Duration.zero,
            () => showMyDialog(
              false,
              S.of(context).showDialogOutdated,
            ),
          );
        } else if (splashTile?.checkResult ==
            S.of(context).suitableVersionResult) {
          Future.delayed(
            Duration.zero,
            () => showMyDialog(
              true,
              S.of(context).showDialogSuitable,
            ),
          );
        } else {
          const SizedBox.shrink();
        }
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
