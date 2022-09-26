import 'package:domain/model/response_model_people.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/base/bloc_screen.dart';
import 'package:presentation/base/tile_wrapper.dart';
import 'package:presentation/colors_application/colors_application.dart';
import 'package:presentation/generated/l10n.dart';
import 'package:presentation/library/dimens/dimens.dart';
import 'package:presentation/library/images_utils/images_utils.dart';
import 'package:presentation/library/images_utils/style_image.dart';
import 'package:presentation/library/style/text_style.dart';
import 'package:presentation/library/widgets/shimmer_details_cast.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/ui/movie_details/bloc/movie_details_bloc.dart';
import 'package:presentation/ui/movie_details/data/movie_details_screen_data.dart';
import 'package:presentation/ui/movie_details/details_arguments/movie_details_arguments.dart';
import 'package:presentation/ui/movie_page/model/movie_row_data.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({super.key});

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
  State<StatefulWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState
    extends BlocScreenState<MovieDetailsWidget, MovieDetailsBloc> {
  @override
  Widget build(BuildContext context) {
    const iconEmpty = Icon(
      Icons.star_border_purple500_sharp,
      color: ColorsApplication.colorStars,
    );
    return StreamBuilder<TileWrapper<MovieDetailsScreenData?>>(
      stream: bloc.dataStream,
      builder: (_, snapshot) {
        final data = snapshot.data;
        final screenData = data?.data;
        final movie = screenData?.movie;
        if (movie == null || data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
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
                  color: ColorsApplication.colorTitle,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: Dimens.padding18,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      ImagesUtils.vector,
                      color: ColorsApplication.colorTitle,
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _PosterWidget(
                    movie: movie,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Dimens.height150,
                    ),
                    child: Column(
                      children: [
                        _TitleWidget(
                          movie: movie,
                        ),
                        const SizedBox(
                          height: Dimens.height30,
                        ),
                        _RatingBarWidget(
                          movie: movie,
                          iconEmpty: iconEmpty,
                        ),
                        const _TabBarWidget(),
                        _OverViewWidget(
                          movie: movie,
                        ),
                        const _ViewAllWidget(),
                        _CastWidget(
                          screenData: screenData!,
                        ),
                      ],
                    ),
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

class _TitleWidget extends StatelessWidget {
  final MovieRowData movie;

  const _TitleWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          movie.title,
          style: sfProSemi24(
            color: ColorsApplication.colorTitle,
          ),
          maxLines: 2,
        ),
        const SizedBox(
          height: Dimens.height16,
        ),
        Text(
          '${movie.runtime} | ${movie.certification}',
          style: sfProSemi16(
            color: ColorsApplication.colorSubTitle,
          ),
        ),
        const SizedBox(height: 9),
        Text(
          '${movie.genres}',
          style: sfProSemi16(
            color: ColorsApplication.colorSubTitle,
          ),
        ),
      ],
    );
  }
}

class _ViewAllWidget extends StatelessWidget {
  const _ViewAllWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimens.padding20,
        left: Dimens.padding18,
        right: Dimens.padding18,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).castCrew,
            style: sfProMed14(
              color: ColorsApplication.colorTitle,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              S.of(context).viewAll,
              style: const TextStyle(
                fontSize: Dimens.size14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OverViewWidget extends StatelessWidget {
  final MovieRowData movie;

  const _OverViewWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimens.padding18,
        right: Dimens.padding18,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpandablePanel(
              header: Text(
                S.of(context).synopsis,
                style: sfProMed18(
                  color: ColorsApplication.colorTitle,
                ),
              ),
              collapsed: Text(
                movie.overview,
                style: sfProMed14(
                  color: ColorsApplication.colorTitle,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                softWrap: true,
              ),
              expanded: Text(
                movie.overview,
                style: sfProMed14(
                  color: ColorsApplication.colorTitle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabBarWidget extends StatelessWidget {
  const _TabBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: Dimens.padding32,
          top: Dimens.padding40,
          right: Dimens.padding18,
          left: Dimens.padding18,
        ),
        height: Dimens.height36,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorsApplication.colorBorder,
          ),
          color: ColorsApplication.colorTheme,
          borderRadius: BorderRadius.circular(
            Dimens.border20,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            Dimens.padding4,
          ),
          child: TabBar(
            indicator: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(
                Dimens.border16,
              ),
            ),
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: Dimens.width6,
                    ),
                    Text(
                      S.of(context).details,
                      style: sfProMed14(
                        color: ColorsApplication.colorTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: Dimens.width6,
                    ),
                    Text(
                      S.of(context).reviews,
                      style: sfProMed14(
                        color: ColorsApplication.colorTitle,
                      ),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: Dimens.width6,
                    ),
                    Text(
                      S.of(context).showtime,
                      style: sfProMed14(
                        color: ColorsApplication.colorTitle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RatingBarWidget extends StatelessWidget {
  final MovieRowData movie;
  final Icon iconEmpty;


  const _RatingBarWidget({
    Key? key,
    required this.movie,
    required this.iconEmpty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${movie.rating.toStringAsFixed(1)}/5',
          style: sfProSemi30(
            color: ColorsApplication.colorTitle,
          ),
        ),
        const SizedBox(
          width: Dimens.width8,
        ),
        RatingBar(
          itemSize: Dimens.size28,
          initialRating: movie.rating,
          itemCount: 5,
          allowHalfRating: true,
          ignoreGestures: true,
          ratingWidget: RatingWidget(
            full: const Icon(
              Icons.star,
              color: ColorsApplication.colorStars,
            ),
            half: iconEmpty,
            empty: iconEmpty,
          ),
          onRatingUpdate: (r) {},
        ),
      ],
    );
  }
}

class _PosterWidget extends StatelessWidget {
  final MovieRowData movie;

  const _PosterWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: Dimens.height218,
          width: Dimens.widthInfinity,
          child: imagePoster(
            imageNetwork: movie.image,
          ),
        ),
        Positioned(
          top: Dimens.height26,
          child: IconButton(
            onPressed: () {},
            iconSize: Dimens.size40,
            icon: SvgPicture.asset(
              ImagesUtils.buttonPlay,
            ),
          ),
        ),
        Positioned(
          top: Dimens.height100,
          child: SizedBox(
            height: Dimens.height250,
            width: Dimens.width166,
            child: imagePoster(
              imageNetwork: movie.image,
            ),
          ),
        ),
      ],
    );
  }
}

class _CastWidget extends StatelessWidget {
  final MovieDetailsScreenData screenData;

  const _CastWidget({
    Key? key,
    required this.screenData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ResponseModelPeople>? cast = screenData.cast;
    if (cast == null) {
      return const ShimmerDetailsCast();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.padding18,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: cast
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.all(
                    Dimens.padding8,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Dimens.width50,
                        height: Dimens.height50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            Dimens.border24,
                          ),
                          child: FadeInImage.assetNetwork(
                            alignment: Alignment.centerLeft,
                            placeholder: ImagesUtils.imageStarMovie,
                            image: e.image,
                            fit: BoxFit.cover,
                            imageErrorBuilder: (
                              context,
                              error,
                              stackTrace,
                            ) {
                              return Image.asset(
                                ImagesUtils.imageStarMovie,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: Dimens.width22,
                      ),
                      SizedBox(
                        width: Dimens.width96,
                        child: Text(
                          e.person,
                          maxLines: 3,
                          textAlign: TextAlign.start,
                          style: sfProMed14(
                            color: ColorsApplication.colorTitle,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: Dimens.width20,
                      ),
                      Text(
                        '• • •',
                        style: sfProMed14(
                          color: ColorsApplication.colorSubTitle,
                        ),
                      ),
                      const SizedBox(
                        width: Dimens.width20,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 70,
                          child: Text(
                            e.characters,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            style: sfProMed14(
                              color: ColorsApplication.colorSubTitle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
