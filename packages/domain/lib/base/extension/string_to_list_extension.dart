extension StringToListExtension on String? {
  List<String>? get stringToList {
    return this != null ? this?.split(',') : [];
  }
}
