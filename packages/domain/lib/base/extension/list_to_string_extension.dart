extension ListToStringExtension on List<String>? {
  String? get listToString {
    return this != null ? this?.join(',') : '';
  }
}
