abstract class AnalyticsService {
  Future<void> analyticsEvent(
    String eventName, {
    Map<String, dynamic>? payload,
  });
}
