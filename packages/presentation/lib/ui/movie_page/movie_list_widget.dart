import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:presentation/Library/images_utils/images_utils.dart';
import 'package:presentation/Library/widgets/shimmer_movie.dart';
import 'package:presentation/app_colors/app_colors.dart';
import 'package:presentation/ui/movie_page/bloc/movie_bloc.dart';
import 'package:presentation/ui/movie_page/model/movie_row_data.dart';

class MovieListWidget extends StatelessWidget {
  final List<MovieRowData>? rowData;
  final MovieBloc bloc;

  const MovieListWidget({
    Key? key,
    required this.rowData,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (rowData == null) {
      return const ShimmerWidget();
    }
    return GridView.builder(
      itemCount: rowData?.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: (.1 / .21),
        crossAxisCount: 2,
        mainAxisSpacing: 30,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (_, index) {
        final movie = rowData![index];
        return _CardMovieWidget(
          movie: movie,
          bloc: bloc,
        );
      },
    );
  }
}

class _CardMovieWidget extends StatelessWidget {
  final MovieRowData movie;
  final MovieBloc bloc;

  const _CardMovieWidget({
    Key? key,
    required this.movie,
    required this.bloc,
  }) : super(key: key);

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
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    ImagesUtils.imageStarMovie,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            const SizedBox(height: 16.44),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(color: AppColors.colorTitle),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
                RatingBar(
                  itemSize: 14,
                  initialRating: movie.rating,
                  itemCount: 5,
                  allowHalfRating: true,
                  ratingWidget: RatingWidget(
                    full: const Icon(
                      Icons.star,
                      color: AppColors.colorStars,
                    ),
                    half: const Icon(
                      Icons.star_border_purple500_sharp,
                      color: AppColors.colorStars,
                    ),
                    empty: const Icon(
                      Icons.star_border_purple500_sharp,
                      color: AppColors.colorStars,
                    ),
                  ),
                  onRatingUpdate: (r) {},
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${movie.genres} · '
                        '${movie.runtime} | ${movie.certification}',
                        style: const TextStyle(
                          color: AppColors.colorSubTitle,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => bloc.onMovieTap(),
          ),
        )
      ],
    );
  }
}
