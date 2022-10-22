import 'package:domain/base/mappers/base_mappers/mapper_base.dart';

class IsTodayDateMapper extends Mapper<DateTime?, bool> {
  @override
  bool call(DateTime? params) {
    if (params != null) {
      final currentDate = DateTime.now();
      return currentDate.year == params.year &&
          currentDate.month == params.month &&
          currentDate.day == params.day;
    } else {
      return false;
    }
  }
}
