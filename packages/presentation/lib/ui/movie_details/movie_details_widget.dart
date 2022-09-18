import 'package:flutter/material.dart';
import 'package:presentation/app_colors/app_colors.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/ui/movie_details/details_arguments/movie_details_arguments.dart';

class MovieDetailsWidget extends StatelessWidget {
  const MovieDetailsWidget({Key? key}) : super(key: key);

  static const _routeName = '/DetailsWidget';

  static BasePage page(MovieDetailsArguments arguments) => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const MovieDetailsWidget(),
        showSlideAnim: true,
        arguments: arguments,
    showBottomBar: true,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(
          "On development stage",
          style: TextStyle(
            fontSize: 34,
            color: AppColors.colorBorder,
          ),
        ),
      ),
    );
  }
}
