import 'package:domain/model/app_version_model.dart';

abstract class VersionCollectionRepository {
  Future<VersionCollectionModel> requestVersions();
}