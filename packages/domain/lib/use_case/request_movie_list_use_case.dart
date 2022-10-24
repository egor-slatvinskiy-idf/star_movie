import 'package:domain/base/mappers/date_load_mapper.dart';
import 'package:domain/base/mappers/get_date_load_mapper.dart';
import 'package:domain/const/configuration.dart';
import 'package:domain/entity/movie_list_response/movie_list_response.dart';
import 'package:domain/repository/database_repository.dart';
import 'package:domain/repository/network_trakt_repository.dart';
import 'package:domain/repository/preferences_local_repository.dart';
import 'package:domain/use_case/sample_use_case/use_case_in_out.dart';

const _limitCountPage = 5;

enum TypeListMovie {
  trending,
  coming,
}

class RequestMovieListUseCase
    extends UseCaseInOut<TypeListMovie, Future<List<MovieListResponse>>> {
  final NetworkTraktRepository _networkRepository;
  final DatabaseRepository _databaseRepository;
  final PreferencesLocalRepository _preferencesLocalRepository;
  final IsTodayDateMapper isTodayDateMapper;
  final GetLoadDateMapper getLoadDateMapper;

  RequestMovieListUseCase(
    this._networkRepository,
    this._databaseRepository,
    this._preferencesLocalRepository,
    this.isTodayDateMapper,
    this.getLoadDateMapper,
  );

  @override
  Future<List<MovieListResponse>> call(TypeListMovie params) async {
    final dateLoad = params == TypeListMovie.trending
        ? _preferencesLocalRepository.getDateLoadTrendingMovieList()
        : _preferencesLocalRepository.getDateLoadComingMovieList();
    if (isTodayDateMapper(dateLoad)) {
      return await _databaseRepository.readMovieList(params);
    } else {
      final List<MovieListResponse> movieList = [];
      await _requestListMovie(
        movieList: movieList,
        countItem: await _getCountItemAndSaveDate(params),
        params: params,
      );
      await _compareListWithDb(
        movieList,
        params,
      );
      return movieList;
    }
  }

  Future<void> _compareListWithDb(
    List<MovieListResponse> movieList,
    TypeListMovie params,
  ) async {
    final newListId = movieList.map((e) => e.movie?.ids?.trakt).toList();
    if (await _databaseRepository.isEqualToMovieListWithDb(newListId, params)) {
      await _databaseRepository.deleteMovieList(params);
      await _databaseRepository.insertMovieList(movieList, params);
    }
  }

  Future<String> _getCountItemAndSaveDate(TypeListMovie params) async {
    final response = params == TypeListMovie.trending
        ? await _networkRepository.requestMovieListTrending(limit: null)
        : await _networkRepository.requestMovieListComing(limit: null);
    _saveLoadDate(response.headers);
    final countPage = int.tryParse(
      response.headers[Configuration.pageCount]?[0] ?? '',
    );
    final countItem = countPage! >= _limitCountPage
        ? Configuration.queryConfigLimit
        : response.headers[Configuration.itemCount]?[0] ?? '';
    return countItem;
  }

  void _saveLoadDate(Map<String, List<String>> headers) {
    final currentDate = getLoadDateMapper(headers);
    if (currentDate != null) {
      _preferencesLocalRepository.saveDateLoadTrendingMovieList(currentDate);
    }
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
