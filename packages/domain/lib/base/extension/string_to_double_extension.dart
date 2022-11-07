extension StringToVersionFormatExtension on String {
  int get toIntVersionFormat {
    return int.parse(split('.').join());
  }
}
