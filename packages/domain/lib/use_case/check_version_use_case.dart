import 'package:domain/base/extension/string_to_double_extension.dart';
import 'package:domain/repository/app_version_repository.dart';
import 'package:domain/use_case/sample_use_case/use_case_out.dart';

enum TypeNotificationVersion {
  outdatedVersion,
  suitableVersion,
}

class CheckVersionUseCase extends UseCaseOut<Future<TypeNotificationVersion?>> {
  final AppVersionRepository versionRepository;

  CheckVersionUseCase(this.versionRepository);

  @override
  Future<TypeNotificationVersion?> call() async {
    final versionCollection = await versionRepository.requestVersions();
    final minVersion = versionCollection.minVersion.toIntVersionFormat;
    final actualVersion = versionCollection.actualVersion.toIntVersionFormat;
    final currentVersion = versionCollection.currentVersion.toIntVersionFormat;
    if (minVersion > currentVersion) {
      return TypeNotificationVersion.outdatedVersion;
    } else if (actualVersion <= currentVersion) {
      return null;
    } else if (actualVersion > currentVersion && minVersion <= currentVersion) {
      return TypeNotificationVersion.suitableVersion;
    } else {
      return null;
    }
  }
}
