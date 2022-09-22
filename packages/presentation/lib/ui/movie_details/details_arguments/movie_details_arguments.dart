import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/ui/movie_page/model/movie_row_data.dart';

class MovieDetailsArguments extends BaseArguments {
  MovieRowData movie;

  MovieDetailsArguments({
    required this.movie,
    Function(dynamic value)? result,
  }) : super(
          result: result,
        );
}
