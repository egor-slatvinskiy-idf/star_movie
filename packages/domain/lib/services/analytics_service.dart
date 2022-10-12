abstract class AnalyticsService {
  Future<void> analyticsEvent({
    required String eventName,
    Map<String, dynamic>? payload,
  });
}
