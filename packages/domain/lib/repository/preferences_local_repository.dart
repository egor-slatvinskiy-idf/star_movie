import 'package:domain/model/firebase_user_email.dart';

abstract class PreferencesLocalRepository {
  Future<void> saveLoggedUser(UserEmailPass user);

  Future saveDateLoadTrendingMovieList(DateTime date);

  DateTime? getDateLoadTrendingMovieList();

  Future saveDateLoadComingMovieList(DateTime date);

  DateTime? getDateLoadComingMovieList();
}
