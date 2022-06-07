 import 'package:actor/appCore/networking/custom_interceptor.dart';
import 'package:dio/dio.dart';

class ApiService {
  static final interceptors = [
    CustomInterceptor(),
    LogInterceptor(
      requestHeader: true,
      request: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
    )
  ];
  final Dio dioClient = Dio(
    BaseOptions(
      baseUrl:
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=de1b8c9dbc154837ad9b6370431a6c93',
      connectTimeout: 60000,
      receiveTimeout: 60000,
    ),
  )..interceptors.addAll(interceptors);
}
