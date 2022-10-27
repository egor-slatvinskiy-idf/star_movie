import 'dart:io';
import 'base_mappers/mapper_base.dart';

class GetLoadDateMapper extends Mapper<Map<String, List<String>>, DateTime?> {
  @override
  DateTime? call(Map<String, List<String>> params) {
    final date = params['date']?.first ?? '';
    return HttpDate.parse(date);
  }
}
