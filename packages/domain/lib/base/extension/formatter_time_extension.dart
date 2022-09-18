extension FormatterTime on int? {
  String get formatter {
    var duration = Duration(minutes: this ?? 0);
    List<String> parts = duration.toString().split(':');
    return '${parts[0].padLeft(2, '')}h ${parts[1].padLeft(2, '0')}m';
  }
}
