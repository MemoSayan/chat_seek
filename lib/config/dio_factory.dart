import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class DioFactory {
  final String baseUrl;

  DioFactory({required this.baseUrl});

  static const String _applicationJson = 'application/json';
  static const String _contentType = 'content-type';
  static const String _accept = 'accept';
  // static const String _authorization = 'authorization';
  static const String _defaultLanguage = 'es';

  static const Duration _receiveTimeout = Duration(seconds: 200);
  static const Duration _connectionTimeout = Duration(seconds: 20);
  static const Duration _sendTimeout = Duration(seconds: 20);

  Dio getDio() {
    final dio = Dio();

    dio.options = _getDioOptions();
    dio.interceptors.addAll(_getInterceptors(dio));

    return dio;
  }

  BaseOptions _getDioOptions() {
    return BaseOptions(
      baseUrl: baseUrl,
      headers: _getDefaultHeaders(),
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,
      connectTimeout: _connectionTimeout,
    );
  }


  Map<String, String> _getDefaultHeaders() {
    return {
      _contentType: _applicationJson,
      _accept: _applicationJson,
      'default_language': _defaultLanguage,
    };
  }


  List<Interceptor> _getInterceptors(Dio dio) {
    final interceptors = <Interceptor>[];


    if (!kReleaseMode) {
      interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Aquí puedes agregar lógica para autenticación, como recuperar un token de sesión
        // options.headers[_authorization] = 'Bearer ${await getToken()}';
        handler.next(options);
      },
      onError: (DioException e, handler) async {
        // Manejo de errores y reintento automático en caso de token expirado
        // if (e.response?.statusCode == 401) {
        //   final newAccessToken = await refreshToken();
        //   e.requestOptions.headers[_authorization] = 'Bearer $newAccessToken';
        //   return handler.resolve(await dio.fetch(e.requestOptions));
        // }
        handler.next(e);
      },
    ));

    return interceptors;
  }
}
