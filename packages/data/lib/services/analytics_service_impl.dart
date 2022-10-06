import 'package:domain/services/analytics_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsServiceImpl implements AnalyticsService {
  final FirebaseAnalytics analytics;

  const AnalyticsServiceImpl(this.analytics);

  @override
  analyticsClick(String logClick) async {
    await analytics.logEvent(name: logClick);
  }
}