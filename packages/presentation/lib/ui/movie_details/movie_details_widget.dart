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
import 'package:presentation/library/images_utils/images_widgets.dart';
import 'package:presentation/library/style/text_style.dart';
import 'package:presentation/library/widgets/shimmer_details_cast.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/ui/movie_details/bloc/movie_details_bloc.dart';
import 'package:presentation/ui/movie_details/data/movie_details_screen_data.dart';
import 'package:presentation/ui/movie_details/details_arguments/movie_details_arguments.dart';
import 'package:presentation/ui/movie_page/model/movie_row_data.dart';

const _lengthController = 3;
const _itemCountRatingBar = 5;

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
              elevation: Dimens.size0,
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
                    right: Dimens.size18,
                  ),
                  child: IconButton(
                    onPressed: () => bloc.share(context),
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
                      top: Dimens.size150,
                    ),
                    child: Column(
                      children: [
                        _TitleWidget(
                          movie: movie,
                        ),
                        const SizedBox(
                          height: Dimens.size30,
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

  const _TitleWidget({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          movie.title,
          style: TextStyles.sfProSemi24(),
          maxLines: Dimens.maxLines3,
        ),
        const SizedBox(
          height: Dimens.size16,
        ),
        Text(
          '${movie.runtime} | ${movie.certification}',
          style: TextStyles.sfProSemi16(
            color: ColorsApplication.colorSubTitle,
          ),
        ),
        const SizedBox(height: Dimens.size8),
        Text(
          '${movie.genres}',
          style: TextStyles.sfProSemi16(
            color: ColorsApplication.colorSubTitle,
          ),
        ),
      ],
    );
  }
}

class _ViewAllWidget extends StatelessWidget {
  const _ViewAllWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimens.size20,
        left: Dimens.size18,
        right: Dimens.size18,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).castCrew,
            style: TextStyles.sfProMed14(),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              S.of(context).viewAll,
              style: TextStyles.sfProMed14(),
            ),
          ),
        ],
      ),
    );
  }
}

class _OverViewWidget extends StatelessWidget {
  final MovieRowData movie;

  const _OverViewWidget({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimens.size18,
        right: Dimens.size18,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpandablePanel(
              header: Text(
                S.of(context).synopsis,
                style: TextStyles.sfProMed18(),
              ),
              collapsed: Text(
                movie.overview,
                style: TextStyles.sfProMed14(),
                overflow: TextOverflow.ellipsis,
                maxLines: Dimens.maxLines4,
                softWrap: true,
              ),
              expanded: Text(
                movie.overview,
                style: TextStyles.sfProMed14(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabBarWidget extends StatelessWidget {
  const _TabBarWidget();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _lengthController,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: Dimens.size32,
          top: Dimens.size40,
          right: Dimens.size18,
          left: Dimens.size18,
        ),
        height: Dimens.size36,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorsApplication.colorBorder,
          ),
          color: ColorsApplication.colorTheme,
          borderRadius: BorderRadius.circular(
            Dimens.size20,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            Dimens.size4,
          ),
          child: TabBar(
            indicator: BoxDecoration(
              color: ColorsApplication.primaryColor,
              borderRadius: BorderRadius.circular(
                Dimens.size16,
              ),
            ),
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: Dimens.size6,
                    ),
                    Text(
                      S.of(context).details,
                      style: TextStyles.sfProMed14(),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: Dimens.size6,
                    ),
                    Text(
                      S.of(context).reviews,
                      style: TextStyles.sfProMed14(),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: Dimens.size6,
                    ),
                    Text(
                      S.of(context).showtime,
                      style: TextStyles.sfProMed14(),
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
    required this.movie,
    required this.iconEmpty,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${movie.rating.toStringAsFixed(1)}/5',
          style: TextStyles.sfProSemi30(),
        ),
        const SizedBox(
          width: Dimens.size8,
        ),
        RatingBar(
          itemSize: Dimens.size28,
          initialRating: movie.rating,
          itemCount: _itemCountRatingBar,
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

  const _PosterWidget({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: Dimens.size218,
          width: Dimens.sizeInfinity,
          child: imagePoster(
            imageNetwork: movie.image,
          ),
        ),
        Positioned(
          top: Dimens.size26,
          child: IconButton(
            onPressed: () {},
            iconSize: Dimens.size40,
            icon: SvgPicture.asset(
              ImagesUtils.buttonPlay,
            ),
          ),
        ),
        Positioned(
          top: Dimens.size100,
          child: SizedBox(
            height: Dimens.size250,
            width: Dimens.size166,
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

  const _CastWidget({required this.screenData});

  @override
  Widget build(BuildContext context) {
    final List<ResponseModelPeople>? cast = screenData.cast;
    if (cast == null) {
      return const ShimmerDetailsCast();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.size18,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: cast
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.all(
                    Dimens.size8,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Dimens.size50,
                        height: Dimens.size50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            Dimens.size24,
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
                        width: Dimens.size22,
                      ),
                      SizedBox(
                        width: Dimens.size96,
                        child: Text(
                          e.person,
                          maxLines: Dimens.maxLines2,
                          textAlign: TextAlign.start,
                          style: TextStyles.sfProMed14(),
                        ),
                      ),
                      const SizedBox(
                        width: Dimens.size20,
                      ),
                      Text(
                        '• • •',
                        style: TextStyles.sfProMed14(
                          color: ColorsApplication.colorSubTitle,
                        ),
                      ),
                      const SizedBox(
                        width: Dimens.size20,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: Dimens.size70,
                          child: Text(
                            e.characters,
                            maxLines: Dimens.maxLines2,
                            textAlign: TextAlign.start,
                            style: TextStyles.sfProMed14(
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
