import 'package:dio/dio.dart';

abstract class ServicePayLoad {}

class DioServicePayLoad implements ServicePayLoad {
  final Options? options;
  final CancelToken? cancelToken;
  final ProgressCallback? onReceiveProgress;
  final ProgressCallback? onSendProgress;

  DioServicePayLoad({
    this.options,
    this.cancelToken,
    this.onReceiveProgress,
    this.onSendProgress,
  });
}
