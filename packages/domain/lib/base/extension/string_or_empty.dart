extension StringOrEmpty on String? {
  String get orEmpty => this ?? '';
}