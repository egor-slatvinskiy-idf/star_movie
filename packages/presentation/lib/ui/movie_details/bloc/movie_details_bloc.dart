import 'package:presentation/base/bloc.dart';
import 'package:presentation/ui/movie_details/data/movie_details_screen_data.dart';
import 'package:presentation/ui/movie_details/details_arguments/movie_details_arguments.dart';

abstract class MovieDetailsBloc
    extends Bloc<MovieDetailsArguments, MovieDetailsScreenData> {
  factory MovieDetailsBloc() => MovieDetailsBlocImpl();
}

class MovieDetailsBlocImpl
    extends BlocImpl<MovieDetailsArguments, MovieDetailsScreenData>
    implements MovieDetailsBloc {
  MovieDetailsScreenData _screenData = MovieDetailsScreenData();

  MovieDetailsBlocImpl();

  @override
  void initArgs(MovieDetailsArguments arguments) {
    super.initArgs(arguments);
    _screenData = MovieDetailsScreenData(movie: arguments.movie);
    _updateData();
  }

  _updateData() {
    handleData(tile: _screenData);
  }
}
