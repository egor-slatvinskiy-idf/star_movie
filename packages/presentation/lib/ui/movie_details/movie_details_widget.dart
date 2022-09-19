import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/app_colors/app_colors.dart';
import 'package:presentation/base/bloc_screen.dart';
import 'package:presentation/base/tile_wrapper.dart';
import 'package:presentation/library/images_utils/images_utils.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/ui/movie_details/bloc/movie_details_bloc.dart';
import 'package:presentation/ui/movie_details/details_arguments/movie_details_arguments.dart';

class MovieDetailsWidget extends StatefulWidget {
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
  State createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState
    extends BlocScreenState<MovieDetailsWidget, MovieDetailsBloc> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TileWrapper>(
      stream: bloc.dataStream,
      builder: (_, snapshot) {
        return SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              elevation: 0,
              title: IconButton(
                onPressed: () => bloc.onTapBackArrow(),
                icon: SvgPicture.asset(
                  ImagesUtils.arrow,
                  color: AppColors.colorTitle,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 17),
                  child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      ImagesUtils.vector,
                      color: AppColors.colorTitle,
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        height: 218,
                        width: double.infinity,
                        child: FadeInImage.assetNetwork(
                          placeholder: ImagesUtils.imageBackDrop,
                          image: ImagesUtils.imageBackDrop,
                          fit: BoxFit.fitWidth,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              ImagesUtils.imageBackDrop,
                              fit: BoxFit.fitWidth,
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 100,
                        child: SizedBox(
                          height: 250,
                          width: 167,
                          child: Image.asset(
                            ImagesUtils.poster,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
