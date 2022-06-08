import 'package:actor/appCore/network/service.dart';
import 'package:actor/features/home/view/PopularPage.dart';
 import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
RestClient? client;
Dio? dio;
void main() {
  dio = Dio();
  dio?.options.headers['Content-Type'] = 'application/json';
  //dio?.options.headers['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8';

  dio?.interceptors.add(InterceptorsWrapper(
    /*onResponse: ( r ,ResponseInterceptorHandler handler){
      Logger().i(r);
      //return r;
    },*/
      onError: (DioError e, ErrorInterceptorHandler handler){
        final r = e.response;
        //Logger().i(e.response);
        if(r!=null)
          print("MyCode" + r.statusCode.toString());
        print("MyCode" + r!.statusMessage!.toString());
        if (r != null && r.statusCode == 401) {
          print("in_status_401");
        }}
  ));



  client = RestClient(dio!);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:   PopularPeoplePage(),
    );
  }
}

