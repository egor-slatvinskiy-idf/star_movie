import 'package:domain/const/configuration.dart';
import 'package:domain/const/query_configuration.dart';
import 'package:domain/entity/movie_list_response.dart';
import 'package:domain/repository/network_repository.dart';
import 'package:domain/use_case/sample_use_case/use_case_in_out.dart';

enum TypeListMovie {
  trending,
  coming,
}

class RequestMovieListUseCase
    extends UseCaseInOut<TypeListMovie, Future<List<MovieListResponse>>> {
  final NetworkRepository _networkRepository;

  RequestMovieListUseCase(
    this._networkRepository,
  );

  @override
  Future<List<MovieListResponse>> call(TypeListMovie params) async {
    final response = params == TypeListMovie.trending
        ? await _networkRepository.requestMovieListTrending(
            queryParameters: Configuration.queryEmpty,
          )
        : await _networkRepository.requestMovieListComing(
            queryParameters: Configuration.queryEmpty,
          );
    final List<MovieListResponse> movieList = [];
    final countPage = int.tryParse(
      response.headers[Configuration.pageCount][0],
    );
    final countItem = countPage! >= 5
        ? QueryConfiguration.queryConfigLimit
        : response.headers[Configuration.itemCount][0];
    await _requestListMovie(
      movieList: movieList,
      countItem: countItem,
      params: params,
    );
    return movieList;
  }

  Future<List<MovieListResponse>> _requestListMovie({
    required List<MovieListResponse> movieList,
    required String countItem,
    TypeListMovie? params,
  }) async {
    Configuration.queryParameters
        .update(QueryConfiguration.queryNameLimit, (value) => countItem);
    final response = params == TypeListMovie.trending
        ? await _networkRepository.requestMovieListTrending(
            queryParameters: Configuration.queryParameters,
          )
        : await _networkRepository.requestMovieListComing(
            queryParameters: Configuration.queryParameters,
          );
    movieList.addAll(
      response.body.map(
        (e) => MovieListResponse.fromJson(e),
      ),
    );
    return movieList;
  }
}
