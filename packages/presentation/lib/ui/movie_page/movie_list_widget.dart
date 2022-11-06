// ignore_for_file: must_call_super
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:presentation/base/tile_wrapper.dart';
import 'package:presentation/colors_application/colors_application.dart';
import 'package:presentation/generated/l10n.dart';
import 'package:presentation/library/dimens/dimens.dart';
import 'package:presentation/library/images_utils/images_utils.dart';
import 'package:presentation/library/style/text_style.dart';
import 'package:presentation/library/widgets/shimmer_movie.dart';
import 'package:presentation/ui/movie_page/bloc/movie_bloc.dart';
import 'package:presentation/ui/movie_page/bloc/movie_list_tile.dart';
import 'package:presentation/ui/movie_page/model/movie_row_data.dart';

const _ratingItemCount = 5;

class MovieListWidget extends StatefulWidget {
  final List<MovieRowData>? rowData;
  final TileWrapper<MovieListTile>? data;
  final MovieBloc bloc;

  const MovieListWidget({
    required this.rowData,
    required this.bloc,
    required this.data,
    super.key,
  });

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget>
    with AutomaticKeepAliveClientMixin<MovieListWidget> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    if (widget.rowData == null || widget.data?.isLoading == true) {
      return const ShimmerWidget();
    }
    if (widget.rowData!.isEmpty) {
      return Center(
        child: Text(
          S.of(context).sandboxText,
          style: TextStyles.sfProSemi30(),
        ),
      );
    }
    return GridView.builder(
      itemCount: widget.rowData?.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: (Dimens.size01 / Dimens.size021),
        mainAxisSpacing: Dimens.size30H,
        crossAxisSpacing: Dimens.size8W,
        maxCrossAxisExtent: Dimens.size180,
      ),
      itemBuilder: (_, index) {
        final movie = widget.rowData![index];
        return _CardMovieWidget(
          movie: movie,
          bloc: widget.bloc,
        );
      },
    );
  }
}

class _CardMovieWidget extends StatelessWidget {
  final MovieRowData movie;
  final MovieBloc bloc;

  const _CardMovieWidget({
    required this.movie,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FadeInImage.assetNetwork(
                placeholder: ImagesUtils.imageStarMovie,
                image: movie.image,
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
            const SizedBox(height: Dimens.size16),
            _MovieTitleWidget(movie: movie),
          ],
        ),
        _OnTapWidget(
          bloc: bloc,
          movie: movie,
        ),
      ],
    );
  }
}

class _MovieTitleWidget extends StatelessWidget {
  final MovieRowData movie;

  const _MovieTitleWidget({required this.movie});

  @override
  Widget build(BuildContext context) {
    const iconEmpty = Icon(
      Icons.star_border_purple500_sharp,
      color: ColorsApplication.colorStars,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.title,
          style: TextStyles.sfProSemi16(),
          textAlign: TextAlign.start,
          maxLines: Dimens.maxLines1,
        ),
        RatingBar(
          itemSize: Dimens.size14,
          initialRating: movie.rating,
          itemCount: _ratingItemCount,
          allowHalfRating: true,
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
        Row(
          children: [
            Expanded(
              child: Text(
                '${movie.genres} · '
                '${movie.runtime} | ${movie.certification}',
                style: TextStyles.sfProMed12(
                  color: ColorsApplication.colorSubTitle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _OnTapWidget extends StatelessWidget {
  final MovieBloc bloc;
  final MovieRowData movie;

  const _OnTapWidget({
    required this.bloc,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => bloc.onMovieTap(movie: movie),
      ),
    );
  }
}
