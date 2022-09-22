import 'package:domain/model/response_model_people.dart';
import 'package:presentation/ui/movie_page/model/movie_row_data.dart';

class MovieDetailsScreenData {
  final MovieRowData? movie;
  final List<ResponseModelPeople>? cast;

  MovieDetailsScreenData({
    this.movie,
    this.cast,
  });
}
