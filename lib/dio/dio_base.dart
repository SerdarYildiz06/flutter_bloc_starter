import 'package:dio/dio.dart';

import 'api/user_api.dart';

class DioBase with UserApi {
  Dio? _dio;

  static final DioBase _dioBase = DioBase.internal();

  factory DioBase() {
    return _dioBase;
  }

  Dio? getDio() {
    if (_dio == null) {
      _dio = Dio();
      _dio!.options.connectTimeout = 100000;
      _dio!.options.receiveTimeout = 100000;
      _dio!.options.sendTimeout = 100000;
    }
    return _dio;
  }

  DioBase.internal();
}
