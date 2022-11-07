import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/model/app_version_model.dart';
import 'package:domain/repository/app_version_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

const _versionCollection = 'star_movie_version';
const _minVersion = 'min';
const _actualVersion = 'actual';

class AppVersionRepositoryImpl implements AppVersionRepository {
  final FirebaseFirestore firebaseFirestore;
  final PackageInfo packageInfo;

  const AppVersionRepositoryImpl(
    this.firebaseFirestore,
    this.packageInfo,
  );

  @override
  Future<AppVersionModel> requestVersions() async {
    final responseVersion =
        await firebaseFirestore.collection(_versionCollection).get();
    final version = responseVersion.docs.first;
    return AppVersionModel(
      minVersion: version[_minVersion],
      actualVersion: version[_actualVersion],
      currentVersion: packageInfo.version,
    );
  }
}
