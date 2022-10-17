import 'package:domain/services/analytics_service.dart';
import 'package:domain/use_case/sample_use_case/use_case_in.dart';

const _screenView = 'screen_view';
const _eventName = 'screen';

class AnalyticsPageUseCase extends UseCaseIn<String> {
  final AnalyticsService analytics;

  AnalyticsPageUseCase(this.analytics);

  @override
  call(String params) => analytics.analyticsEvent(
        _screenView,
        payload: {_eventName: params},
      );
}
