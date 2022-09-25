import 'package:domain/model/response_model_people.dart';
import 'package:presentation/ui/movie_page/model/movie_row_data.dart';

class MovieDetailsScreenData {
  final MovieRowData? movie;
  final List<ResponseModelPeople>? cast;

  MovieDetailsScreenData({
    this.movie,
    this.cast,
  });

  MovieDetailsScreenData copyWith({
    MovieRowData? movie,
    List<ResponseModelPeople>? cast,
  }) {
    return MovieDetailsScreenData(
      movie: movie ?? this.movie,
      cast: cast ?? this.cast,
    );
  }
}
