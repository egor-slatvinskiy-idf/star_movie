import 'package:domain/use_case/log_analytics_button_use_case.dart';
import 'package:domain/use_case/request_movie_list_use_case.dart';
import 'package:presentation/base/bloc.dart';
import 'package:presentation/library/const/event_name.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/ui/movie_details/details_arguments/movie_details_arguments.dart';
import 'package:presentation/ui/movie_details/movie_details_widget.dart';
import 'package:presentation/ui/movie_page/bloc/movie_list_tile.dart';
import 'package:presentation/ui/movie_page/mapper/mapper_movie_list.dart';
import 'package:presentation/ui/movie_page/model/movie_row_data.dart';

abstract class MovieBloc extends Bloc<BaseArguments, MovieListTile> {
  factory MovieBloc(
    RequestMovieListUseCase requestMovieListUseCase,
    MapperMovieList mapperMovieList,
    LogAnalyticsButtonUseCase analyticsUseCase,
  ) =>
      MovieBlocImpl(
        requestMovieListUseCase,
        mapperMovieList,
        analyticsUseCase,
      );

  void loadMovieComing();

  void loadMovieTrending();

  void onMovieTap({
    required MovieRowData movie,
  });
}

class MovieBlocImpl extends BlocImpl<BaseArguments, MovieListTile>
    implements MovieBloc {
  var _tile = MovieListTile.init();
  final RequestMovieListUseCase _requestMovieListUseCase;
  final MapperMovieList _mapperMovieList;
  final LogAnalyticsButtonUseCase logButtonUseCase;

  MovieBlocImpl(
    this._requestMovieListUseCase,
    this._mapperMovieList,
    this.logButtonUseCase,
  );

  @override
  void initState() {
    super.initState();
    loadMovieTrending();
  }

  @override
  void loadMovieTrending() async {
    handleData(isLoading: true);
    final movieResponseTrending = await _requestMovieListUseCase(
      TypeListMovie.trending,
    );
    final movieMapTrending = _mapperMovieList(
      movieResponseTrending,
    );
    await logButtonUseCase(EventName.movieTrendingClick);
    _tile = _tile.copyWith(movieTrending: movieMapTrending);
    handleData(
      tile: _tile,
      isLoading: false,
    );
  }

  @override
  void loadMovieComing() async {
    handleData(isLoading: true);
    final movieResponseComing = await _requestMovieListUseCase(
      TypeListMovie.coming,
    );
    final movieMapComing = _mapperMovieList(
      movieResponseComing,
    );
    await logButtonUseCase(EventName.movieComingClick);
    _tile = _tile.copyWith(movieComing: movieMapComing);
    handleData(
      tile: _tile,
      isLoading: false,
    );
  }

  @override
  void onMovieTap({
    required MovieRowData movie,
  }) async {
    await logButtonUseCase(EventName.movieClick);
    appNavigator.push(
      MovieDetailsWidget.page(
        MovieDetailsArguments(movie: movie),
      ),
    );
  }
}
