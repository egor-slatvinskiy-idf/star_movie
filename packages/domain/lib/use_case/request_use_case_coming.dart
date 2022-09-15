import 'package:domain/const/configuration.dart';
import 'package:domain/entity/movie_coming_response.dart';
import 'package:domain/repository/network_repository.dart';
import 'package:domain/use_case/sample_use_case/use_case_out.dart';

class RequestUseCaseComing
    extends UseCaseOut<Future<List<MovieResponseComing>>> {
  final NetworkRepository _networkRepository;

  RequestUseCaseComing(
    this._networkRepository,
  );

  @override
  Future<List<MovieResponseComing>> call() async {
    final response = await _networkRepository.requestMovie(
      apiPath: Configuration.endPointComing,
      queryParameters: Configuration.queryEmpty,
    );
    final List<MovieResponseComing> movieComing = [];
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
        apiPath: Configuration.endPointComing,
      );
      movieComing.addAll(
        responseFull.body.map(
          (e) => MovieResponseComing.fromJson(e),
        ),
      );
    } else {
      final responseSpare = await _networkRepository.requestMovie(
        apiPath: Configuration.endPointTrending,
        queryParameters: Configuration.queryParameters.update(
          Configuration.nameLimit,
          (v) => '$countItem',
        ),
      );
      movieComing.addAll(
        responseSpare.body.map(
          (e) => MovieResponseComing.fromJson(e),
        ),
      );
    }
    return movieComing;
  }
}
