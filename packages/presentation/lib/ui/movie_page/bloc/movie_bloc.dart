import 'package:domain/use_case/request_movie_list_use_case.dart';
import 'package:presentation/base/bloc.dart';
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
  ) =>
      MovieBlocImpl(
        requestMovieListUseCase,
        mapperMovieList,
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

  MovieBlocImpl(
    this._requestMovieListUseCase,
    this._mapperMovieList,
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
    _tile = _tile.copyWith(movieComing: movieMapComing);
    handleData(
      tile: _tile,
      isLoading: false,
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
