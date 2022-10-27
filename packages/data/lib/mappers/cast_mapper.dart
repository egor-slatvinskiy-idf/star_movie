import 'package:data/database/database_model/cast_model.dart';
import 'package:domain/base/mappers/base_mappers/mapper_base.dart';
import 'package:domain/model/response_model_people.dart';

class CastMapper
    extends Mapper<List<Map<String, Object?>>, List<ResponseModelPeople>> {
  @override
  List<ResponseModelPeople> call(List<Map<String, Object?>> params) => params
      .map((json) => CastModel.fromJson(json)).toList()
      .map((e) => e.toPeopleModel()).toList();
}
