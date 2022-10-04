import 'package:firebase_analytics/firebase_analytics.dart';

class Analytics {
  final FirebaseAnalytics analytics;

  const Analytics(this.analytics);

  analyticsFacebookClick() async {
    await analytics.logEvent(name: 'on_facebook_click');
  }

  analyticsGoogleClick() async {
    await analytics.logEvent(name: 'on_google_click');
  }

  analyticsLoginClick() async {
    await analytics.logEvent(name: 'on_login_click');
  }
}
