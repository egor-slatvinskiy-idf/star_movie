import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/model/app_version_model.dart';
import 'package:domain/repository/app_version_repository.dart';

const _versionCollection = 'star_movie_version';
const _minVersion = 'min';
const _actualVersion = 'actual';

class VersionCollectionRepositoryImpl implements VersionCollectionRepository {
  final FirebaseFirestore _firebaseFirestore;

  const VersionCollectionRepositoryImpl(this._firebaseFirestore);

  @override
  Future<VersionCollectionModel> requestVersions() async {
    final responseVersion =
        await _firebaseFirestore.collection(_versionCollection).get();
    final version = responseVersion.docs.first;
    return VersionCollectionModel(
      minVersion: version[_minVersion],
      actualVersion: version[_actualVersion],
    );
  }
}
