import 'package:domain/base/mappers/delete_movie_mapper.dart';
import 'package:domain/base/mappers/get_date_load_mapper.dart';
import 'package:domain/base/mappers/movie_list_mapper.dart';
import 'package:domain/base/mappers/update_movie_mapper.dart';
import 'package:domain/base/utils/update_or_delete_movie_model.dart';
import 'package:domain/base/utils/utils.dart';
import 'package:domain/const/configuration.dart';
import 'package:domain/entity/movie_list_response/movie_list_response.dart';
import 'package:domain/repository/database_repository.dart';
import 'package:domain/repository/network_trakt_repository.dart';
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
  final GetLoadDateMapper getLoadDateMapper;
  final UpdateMovieMapper updateMovieMapper;
  final DeleteMovieMapper deleteMovieMapper;
  final MovieListMapper movieListMapper;

  RequestMovieListUseCase(
    this._networkRepository,
    this._databaseRepository,
    this.getLoadDateMapper,
    this.updateMovieMapper,
    this.deleteMovieMapper,
    this.movieListMapper,
  );

  @override
  Future<List<MovieListResponse>> call(TypeListMovie params) async {
    final dateLoad = await _databaseRepository.readDateLoadMovie(params);
    if (Utils.isTodayDate(dateLoad)) {
      final movieListFromDb = await _databaseRepository.readMovieList(params);
      return movieListMapper(movieListFromDb);
    } else {
      final List<MovieListResponse> movieList = [];
      await _requestListMovie(
        movieList: movieList,
        countItem: await _getCountItemAndSaveDate(
          params,
          dateLoad,
        ),
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
    final movieListFromDb = await _databaseRepository.readMovieList(params);
    final comparedUpdateList = updateMovieMapper(
      UpdateOrDeleteMovieModel(
        movieListFromDb: movieListFromDb,
        movieListFromTrakt: movieList,
        typeListMovie: params,
      ),
    );
    if (comparedUpdateList.isNotEmpty) {
      final moviesId = deleteMovieMapper(
        UpdateOrDeleteMovieModel(
          movieListFromDb: movieListFromDb,
          movieListFromTrakt: movieList,
          typeListMovie: params,
        ),
      );
      await _databaseRepository.deleteMovieList(
        params,
        moviesId,
      );
      await _databaseRepository.insertMovieList(
        comparedUpdateList,
        params,
      );
    }
  }

  Future<String> _getCountItemAndSaveDate(
    TypeListMovie params,
    DateTime? date,
  ) async {
    final response = params == TypeListMovie.trending
        ? await _networkRepository.requestMovieListTrending(limit: null)
        : await _networkRepository.requestMovieListComing(limit: null);
    await _saveLoadDate(
      response.headers,
      params,
      date,
    );
    final countPage = int.tryParse(
      response.headers[Configuration.pageCount]?[0] ?? '',
    );
    final countItem = countPage! >= _limitCountPage
        ? Configuration.queryConfigLimit
        : response.headers[Configuration.itemCount]?[0] ?? '';
    return countItem;
  }

  Future _saveLoadDate(
    Map<String, List<String>> headers,
    TypeListMovie typeMovie,
    DateTime? date,
  ) async {
    final currentDate = getLoadDateMapper(headers);
    if (currentDate != null) {
      if (date != null) {
        await _databaseRepository.updateDateLoadMovie(
          currentDate.toString(),
          typeMovie,
        );
      } else {
        await _databaseRepository.insertDateLoadMovie(
          currentDate.toString(),
          typeMovie,
        );
      }
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
