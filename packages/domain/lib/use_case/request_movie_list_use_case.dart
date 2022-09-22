import 'package:domain/const/configuration.dart';
import 'package:domain/entity/movie_list_response.dart';
import 'package:domain/repository/network_trakt_repository.dart';
import 'package:domain/use_case/sample_use_case/use_case_in_out.dart';

enum TypeListMovie {
  trending,
  coming,
}

class RequestMovieListUseCase
    extends UseCaseInOut<TypeListMovie, Future<List<MovieListResponse>>> {
  final NetworkTraktRepository _networkRepository;

  RequestMovieListUseCase(
    this._networkRepository,
  );

  @override
  Future<List<MovieListResponse>> call(TypeListMovie params) async {
    final response = params == TypeListMovie.trending
        ? await _networkRepository.requestMovieListTrending(
            limit: null,
          )
        : await _networkRepository.requestMovieListComing(
            limit: null,
          );
    final List<MovieListResponse> movieList = [];
    final countPage = int.tryParse(
      response.headers[Configuration.pageCount][0],
    );
    final countItem = countPage! >= 5
        ? Configuration.queryConfigLimit
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
    final response = params == TypeListMovie.trending
        ? await _networkRepository.requestMovieListTrending(
            limit: countItem,
          )
        : await _networkRepository.requestMovieListComing(
            limit: countItem,
          );
    movieList.addAll(
      response.body.map(
        (e) => MovieListResponse.fromJson(e),
      ),
    );
    return movieList;
  }
}
