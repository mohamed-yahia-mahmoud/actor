import 'package:actor/appCore/network/service.dart';
import 'package:actor/features/home/view/PopularPage.dart';
 import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
RestClient? client;
Dio? dio;
void main() {
  dio = Dio();
  dio?.options.headers['Content-Type'] = 'application/json';
  dio?.interceptors.add(InterceptorsWrapper(
      onError: (DioError e, ErrorInterceptorHandler handler){
        final r = e.response;
        if(r!=null)
          print("MyCode" + r.statusCode.toString());
        print("MyCode" + r!.statusMessage!.toString());
        if (r != null && r.statusCode == 401) {
          print("in_status_401");
        }}
  ));

  client = RestClient(dio!);

  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Color(0xff4391D4)
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      title: 'Popular People',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:   PopularPeoplePage(),
      builder: EasyLoading.init(),
    );
  }
}

