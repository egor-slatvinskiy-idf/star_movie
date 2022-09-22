import 'package:domain/use_case/request_details_use_case.dart';
import 'package:presentation/base/bloc.dart';
import 'package:presentation/ui/movie_details/data/movie_details_screen_data.dart';
import 'package:presentation/ui/movie_details/details_arguments/movie_details_arguments.dart';

abstract class MovieDetailsBloc
    extends Bloc<MovieDetailsArguments, MovieDetailsScreenData> {
  factory MovieDetailsBloc(
    RequestDetailsUseCase requestDetailsUseCase,
  ) =>
      _MovieDetailsBlocImpl(
        requestDetailsUseCase,
      );

  void onTapBackArrow();
}

class _MovieDetailsBlocImpl
    extends BlocImpl<MovieDetailsArguments, MovieDetailsScreenData>
    implements MovieDetailsBloc {
  MovieDetailsScreenData _screenData = MovieDetailsScreenData();
  final RequestDetailsUseCase _detailsUseCase;

  _MovieDetailsBlocImpl(
    this._detailsUseCase,
  );

  @override
  void initArgs(MovieDetailsArguments arguments) async {
    super.initArgs(arguments);
    final id = arguments.movie.ids;
    final response = await _detailsUseCase(id!);
    _screenData = MovieDetailsScreenData(
      movie: arguments.movie,
      cast: response,
    );
    _updateData();
  }

  _updateData() {
    handleData(
      tile: _screenData,
    );
  }

  @override
  void onTapBackArrow() {
    appNavigator.pop();
    _updateData();
  }
}
