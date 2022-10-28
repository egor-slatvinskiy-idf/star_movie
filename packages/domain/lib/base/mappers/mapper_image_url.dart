import 'package:domain/base/mappers/base_mappers/mapper_base.dart';
import 'package:domain/const/configuration.dart';

class MapperImageUrl extends Mapper<String?, String> {
  final String apiKeyOMDB;

  MapperImageUrl(this.apiKeyOMDB);

  @override
  String call(String? params) => '${Configuration.imageUrl(apiKeyOMDB)}$params';
}
