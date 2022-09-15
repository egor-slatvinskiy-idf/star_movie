import 'package:domain/const/configuration.dart';
import 'package:domain/entity/movie_trending_response.dart';
import 'package:domain/repository/network_repository.dart';
import 'package:domain/use_case/sample_use_case/use_case_out.dart';

class RequestUseCaseTrending
    extends UseCaseOut<Future<List<MovieTrendingResponse>>> {
  final NetworkRepository _networkRepository;

  RequestUseCaseTrending(this._networkRepository);

  @override
  Future<List<MovieTrendingResponse>> call() async {
    final response = await _networkRepository.requestMovie(
      apiPath: Configuration.endPointTrending,
      queryParameters: Configuration.queryEmpty,
    );
    final List<MovieTrendingResponse> movieTrending = [];
    final countItem = int.tryParse(
      response.headers[Configuration.itemCount][0],
    );
    final countPage = int.tryParse(
      response.headers[Configuration.pageCount][0] ??
          [Configuration.pageLimit].first,
    );
    if (countPage! >= 5) {
      final responseFull = await _networkRepository.requestMovie(
        queryParameters: Configuration.queryParameters,
        apiPath: Configuration.endPointTrending,
      );
      movieTrending.addAll(
        responseFull.body.map(
          (e) => MovieTrendingResponse.fromJson(e),
        ),
      );
    } else if (countPage < 5) {
      final responseMin = await _networkRepository.requestMovie(
        apiPath: Configuration.endPointTrending,
        queryParameters: Configuration.queryParameters.update(
          Configuration.nameLimit,
          (v) => '$countItem',
        ),
      );
      movieTrending.addAll(
        responseMin.body.map(
          (e) => MovieTrendingResponse.fromJson(e),
        ),
      );
    }
    return movieTrending;
  }
}
