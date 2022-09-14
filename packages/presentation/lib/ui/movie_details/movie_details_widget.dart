import 'package:flutter/material.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/navigation/base_page.dart';

class MovieDetailsArguments extends BaseArguments {
  MovieDetailsArguments({
    Function(dynamic value)? result,
  }) : super(result: result);
}

class MovieDetailsWidget extends StatelessWidget {
  const MovieDetailsWidget({Key? key}) : super(key: key);

  static const _routeName = '/DetailsWidget';

  static BasePage page(MovieDetailsArguments arguments) => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const MovieDetailsWidget(),
        showSlideAnim: true,
        arguments: arguments,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(
          "On development stage",
          style: TextStyle(fontSize: 34, color: Colors.white),
        ),
      ),
    );
  }
}
