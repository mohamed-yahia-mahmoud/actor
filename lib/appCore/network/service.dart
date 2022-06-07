
import 'dart:io';

import 'package:actor/appCore/network/response/PopularPeopleResponse.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'dart:convert';

part 'service.g.dart';
@RestApi(baseUrl: "https://api.themoviedb.org/3")
abstract class RestClient {
factory RestClient(Dio dio) = _RestClient;


  @Header('Accept":"application/json')
  @GET('/person/popular')
  Future<PopularPeopleResponse> getPopularPeople(@Queries() Map<String, dynamic> queries,);


  }
