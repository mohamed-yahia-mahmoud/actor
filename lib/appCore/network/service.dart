
import 'dart:io';

import 'package:actor/appCore/network/response/GetPersonDetailsResponse.dart';
import 'package:actor/appCore/network/response/GetPersonImagesResponse.dart';
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


  @Header('Accept":"application/json')
  @GET('/person/{id}')
  Future<GetPersonDetailsResponse> getPopularPeopleDetails(@Path("id") int? id,@Queries() Map<String, dynamic> queries,);

  @Header('Accept":"application/json')
  @GET('/person/{id}/images')
  Future<GetPersonImagesResponse> getPersonImages(@Path("id") int? id,@Queries() Map<String, dynamic> queries,);



}
