import 'package:domain/model/app_version_model.dart';

abstract class AppVersionRepository {
  Future<AppVersionModel> requestVersions();
}