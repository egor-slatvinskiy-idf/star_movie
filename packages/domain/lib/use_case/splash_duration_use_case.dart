import 'package:domain/use_case/sample_use_case/use_case_out.dart';

const _duration = 1;

class SplashDurationUseCase extends UseCaseOut<Future<void>> {
  @override
  Future<void> call() => splashDuration();

  Future<void> splashDuration() async {
    await Future.delayed(
      const Duration(seconds: _duration),
    );
  }
}
