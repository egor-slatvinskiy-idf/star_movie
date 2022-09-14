import 'dart:io';

import 'package:data/services/api_base_exception.dart';
import 'package:data/services/service_payload.dart';
import 'package:dio/dio.dart';

abstract class ApiBaseService<P extends ServicePayLoad> {
  Future<Response<T>> get<T>(
    String path, {
    bool isResponseBytes = false,
    Map<String, dynamic>? queryParameters,
    DioServicePayLoad? payLoad,
  });

  Future<Response<T>> post<T>(
    String path, {
    bool isResponseBytes = false,
    Map<String, dynamic>? queryParameters,
    DioServicePayLoad? payLoad,
    dynamic data,
  });
}

class ApiBaseServiceImpl implements ApiBaseService<DioServicePayLoad> {
  final Dio _dio;

  ApiBaseServiceImpl(
    this._dio,
  );

  @override
  Future<Response<T>> get<T>(
    String path, {
    bool isResponseBytes = false,
    Map<String, dynamic>? queryParameters,
    DioServicePayLoad? payLoad,
  }) async {
    try {
      final response = _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: payLoad?.options,
        cancelToken: payLoad?.cancelToken,
        onReceiveProgress: payLoad?.onReceiveProgress,
      );
      return response;
    } on SocketException {
      throw ApiBaseException(ApiBaseExceptionType.network);
    } on ApiBaseException {
      rethrow;
    } catch (_) {
      throw ApiBaseException(ApiBaseExceptionType.other);
    }
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    bool isResponseBytes = false,
    Map<String, dynamic>? queryParameters,
    DioServicePayLoad? payLoad,
    dynamic data,
  }) async {
    try {
      final response = _dio.post(
        path,
        queryParameters: queryParameters,
        data: data,
        options: payLoad?.options,
        cancelToken: payLoad?.cancelToken,
        onReceiveProgress: payLoad?.onReceiveProgress,
        onSendProgress: payLoad?.onSendProgress,
      );
      return response as Future<Response<T>>;
    } on SocketException {
      throw ApiBaseException(ApiBaseExceptionType.network);
    } on ApiBaseException {
      rethrow;
    } catch (_) {
      throw ApiBaseException(ApiBaseExceptionType.other);
    }
  }
}
