import 'package:domain/model/firebase_user_email.dart';
import 'package:domain/repository/preferences_local_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _loginKey = 'loggedUserEmail';
const _passwordKey = 'loggedUserPassword';

const _trendingDateKey = 'trendingDateKey';
const _comingDateKey = 'comingDateKey';

class PreferencesLocalRepositoryImpl implements PreferencesLocalRepository {
  final SharedPreferences sharedPreferences;

  const PreferencesLocalRepositoryImpl({required this.sharedPreferences});

  @override
  Future<void> saveLoggedUser(UserEmailPass user) async {
    Future.wait([
      sharedPreferences.setString(
        _loginKey,
        user.login,
      ),
      sharedPreferences.setString(
        _passwordKey,
        user.password,
      ),
    ]);
  }

  @override
  Future saveDateLoadTrendingMovieList(DateTime date) async {
    await sharedPreferences.setString(
      _trendingDateKey,
      date.toString(),
    );
  }

  @override
  DateTime? getDateLoadTrendingMovieList() {
    final date = sharedPreferences.getString(_trendingDateKey);
    if (date == null) {
      return null;
    } else {
      return DateTime.parse(date);
    }
  }

  @override
  Future saveDateLoadComingMovieList(DateTime date) async {
    await sharedPreferences.setString(
      _comingDateKey,
      date.toString(),
    );
  }

  @override
  DateTime? getDateLoadComingMovieList() {
    final date = sharedPreferences.getString(_comingDateKey);
    if (date == null) {
      return null;
    } else {
      return DateTime.parse(date);
    }
  }
}
