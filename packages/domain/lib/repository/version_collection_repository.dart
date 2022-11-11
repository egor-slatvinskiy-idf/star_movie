import 'package:domain/model/version_collection_model.dart';

abstract class VersionCollectionRepository {
  Future<VersionCollectionModel> requestVersions();
}