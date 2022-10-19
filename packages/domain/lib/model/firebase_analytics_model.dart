class FirebaseAnalyticsModel {
  final String eventName;
  final Map<String, dynamic>? eventScreenLog;

  FirebaseAnalyticsModel({
    required this.eventName,
    this.eventScreenLog,
  });
}
