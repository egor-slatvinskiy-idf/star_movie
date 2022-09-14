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
      apiPath: Configuration.apiPathTrending,
      queryParameters: Configuration.queryEmpty,
    );
    final List<MovieTrendingResponse> movieTrending = [];
    final countMovie = (response.headers['x-pagination-limit']).first;
    final count = int.parse(countMovie);
    if (count > 5) {
      final responseFull = await _networkRepository.requestMovie(
        queryParameters: Configuration.queryParameters,
        apiPath: Configuration.apiPathTrending,
      );
      movieTrending.addAll(
        responseFull.body.map(
          (e) => MovieTrendingResponse.fromJson(e),
        ),
      );
    } else if (count < 5) {
      movieTrending.addAll(
        response.body.map(
          (e) => MovieTrendingResponse.fromJson(e),
        ),
      );
    }
    return movieTrending;
  }
}
