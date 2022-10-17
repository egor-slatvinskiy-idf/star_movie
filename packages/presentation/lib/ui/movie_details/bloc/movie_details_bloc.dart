import 'package:domain/use_case/log_analytics_button_use_case.dart';
import 'package:domain/use_case/request_details_use_case.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/base/bloc.dart';
import 'package:presentation/generated/l10n.dart';
import 'package:presentation/library/const/event_name.dart';
import 'package:presentation/ui/movie_details/data/movie_details_screen_data.dart';
import 'package:presentation/ui/movie_details/details_arguments/movie_details_arguments.dart';
import 'package:share_android_ios/share_android_ios.dart';

abstract class MovieDetailsBloc
    extends Bloc<MovieDetailsArguments, MovieDetailsScreenData> {
  factory MovieDetailsBloc(
    RequestDetailsUseCase requestDetailsUseCase,
    LogAnalyticsButtonUseCase analyticsUseCase,
  ) =>
      _MovieDetailsBlocImpl(
        requestDetailsUseCase,
        analyticsUseCase,
      );

  void onTapBackArrow();

  void share(BuildContext context);
}

class _MovieDetailsBlocImpl
    extends BlocImpl<MovieDetailsArguments, MovieDetailsScreenData>
    implements MovieDetailsBloc {
  MovieDetailsScreenData _screenData = const MovieDetailsScreenData();
  final RequestDetailsUseCase _detailsUseCase;
  final LogAnalyticsButtonUseCase logButtonUseCase;

  _MovieDetailsBlocImpl(
    this._detailsUseCase,
    this.logButtonUseCase,
  );

  @override
  void initArgs(MovieDetailsArguments arguments) {
    super.initArgs(arguments);
    final id = arguments.movie.ids;
    _screenData = _screenData.copyWith(movie: arguments.movie);
    _updateData();
    _dataCast(id);
  }

  void _dataCast(int id) async {
    final response = await _detailsUseCase(id);
    _screenData = _screenData.copyWith(cast: response);
    _updateData();
  }

  @override
  void share(BuildContext context) {
    final language = Localizations.localeOf(context).languageCode;
    final movieId = _screenData.movie?.ids ?? '';
    final message = S.of(context).share(movieId, language);
    ShareAndroidIos.share(message);
  }

  _updateData() {
    handleData(
      tile: _screenData,
    );
  }

  @override
  void onTapBackArrow() async {
    await logButtonUseCase(EventName.backMovieClick);
    appNavigator.pop();
  }
}
