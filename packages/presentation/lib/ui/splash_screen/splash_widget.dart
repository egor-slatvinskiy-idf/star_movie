import 'package:flutter/material.dart';
import 'package:presentation/base/bloc_screen.dart';
import 'package:presentation/base/dialog_event.dart';
import 'package:presentation/colors_application/colors_application.dart';
import 'package:presentation/generated/l10n.dart';
import 'package:presentation/library/images_utils/images_utils.dart';
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
  void initState() {
    super.initState();
    bloc.eventStream.listen(
      (event) {
        if (event is VersionWindow) {
          showMyDialog(event);
        }
      },
    );
  }

  Future<void> showMyDialog(VersionWindow content) {
    final message = content.message;
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            message == S.of(context).showDialogSuitable
                ? TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      bloc.laterTap();
                    },
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
  }
}
