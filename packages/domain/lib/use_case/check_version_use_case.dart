import 'package:domain/base/extension/string_to_double_extension.dart';
import 'package:domain/repository/version_collection_repository.dart';
import 'package:domain/use_case/sample_use_case/use_case_out.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum TypeNotificationVersion {
  outdatedVersion,
  suitableVersion,
  actualVersion,
}

class CheckVersionUseCase extends UseCaseOut<Future<TypeNotificationVersion>> {
  final VersionCollectionRepository versionRepository;
  final PackageInfo packageInfo;

  CheckVersionUseCase(
    this.versionRepository,
    this.packageInfo,
  );

  @override
  Future<TypeNotificationVersion> call() async {
    final versionCollection = await versionRepository.requestVersions();
    final minVersion = versionCollection.minVersion.toIntVersionFormat;
    final actualVersion = versionCollection.actualVersion.toIntVersionFormat;
    final currentVersion = packageInfo.version.toIntVersionFormat;
    if (minVersion > currentVersion) {
      return TypeNotificationVersion.outdatedVersion;
    } else if (actualVersion > currentVersion && minVersion <= currentVersion) {
      return TypeNotificationVersion.suitableVersion;
    } else {
      return TypeNotificationVersion.actualVersion;
    }
  }
}
