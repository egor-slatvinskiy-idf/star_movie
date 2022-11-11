extension StringToVersionFormatExtension on String {
  int get toIntVersionFormat {
    return int.parse(replaceAll('.', ''));
  }
}
