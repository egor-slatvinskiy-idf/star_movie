import 'package:flutter/material.dart';
import 'package:presentation/navigation/base_arguments.dart';

class BasePage<T extends BaseArguments> extends Page {
  final WidgetBuilder builder;
  final bool? showSlideAnim;
  final bool showBottomBar;

  const BasePage({
    required this.showBottomBar,
    required LocalKey key,
    required String name,
    required this.builder,
    this.showSlideAnim,
    T? arguments,
  }) : super(
          key: key,
          name: name,
          arguments: arguments,
        );

  @override
  Route createRoute(BuildContext context) => _AppRoute(
        builder: builder,
        settings: this,
        showSlideAnim: showSlideAnim == true,
      );
}

class _AppRoute extends MaterialPageRoute {
  final bool showSlideAnim;

  _AppRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    this.showSlideAnim = false,
  }) : super(
          builder: builder,
          settings: settings,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (!showSlideAnim) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }

    return super.buildTransitions(
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}
