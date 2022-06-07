import 'package:actor/appCore/networking/custom_exception.dart';
import 'package:dio/dio.dart';

class CustomInterceptor implements Interceptor {

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers = {
      "Accept":"application/json",
      'Content-Type': 'application/json',

    };
    return handler.next(options);
  }

  @override
  Future onResponse(Response response, handler) async {
    switch (response.statusCode) {
      case 200:
      // print(response);
        return handler.next(response);
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.data.toString());
      case 500:
      default:
        throw FetchDataException(
            '''Error occurred while Communication with Server with StatusCode :
             ${response.statusCode}''');
    }
  }

  @override
  Future onError(DioError e, handler) async {
    return handler.next(e);
  }
}

