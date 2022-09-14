import 'package:domain/use_case/request_use_case_coming.dart';
import 'package:domain/use_case/request_use_case_trending.dart';
import 'package:presentation/base/bloc.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/ui/movie_details/details_arguments/movie_details_arguments.dart';
import 'package:presentation/ui/movie_details/movie_details_widget.dart';
import 'package:presentation/ui/movie_page/bloc/movie_list_tile.dart';
import 'package:presentation/ui/movie_page/model/movie_row_data.dart';

abstract class MovieBloc extends Bloc<BaseArguments, MovieListTile> {
  factory MovieBloc(
    RequestUseCaseComing requestUseCaseComing,
    RequestUseCaseTrending requestUseCaseTrending,
  ) =>
      MovieBlocImpl(
        requestUseCaseComing,
        requestUseCaseTrending,
      );

  void onMovieTap({
    required MovieRowData movie,
  });
}

class MovieBlocImpl extends BlocImpl<BaseArguments, MovieListTile>
    implements MovieBloc {
  final _tile = MovieListTile.init();
  final RequestUseCaseComing _requestUseCaseComing;
  final RequestUseCaseTrending _requestUseCaseTrending;

  MovieBlocImpl(
    this._requestUseCaseComing,
    this._requestUseCaseTrending,
  );

  @override
  void initState() async {
    super.initState();
    await loadMovie();
  }

  Future<void> loadMovie() async {
    final movieResponseTrending = await _requestUseCaseTrending();
    final movieResponseComing = await _requestUseCaseComing();
    final movieMapTrending = movieResponseTrending
        .map(
          (e) => MovieRowData.fromMovieListResponse(e.movie),
        )
        .toList();
    final movieMapComing = movieResponseComing
        .map(
          (e) => MovieRowData.fromMovieListResponse(e.movie),
        )
        .toList();
    handleData(
      tile: _tile.copyWith(
        movieTrending: movieMapTrending,
        movieComing: movieMapComing,
      ),
    );
  }

  @override
  void onMovieTap({
    required MovieRowData movie,
  }) {
    appNavigator.push(
      MovieDetailsWidget.page(
        MovieDetailsArguments(movie: movie),
      ),
    );
  }
}
