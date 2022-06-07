// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PopularPeopleResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularPeopleResponse _$PopularPeopleResponseFromJson(
        Map<String, dynamic> json) =>
    PopularPeopleResponse(
      page: json['page'],
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['totalPages'],
      totalResults: json['totalResults'],
    );

Map<String, dynamic> _$PopularPeopleResponseToJson(
        PopularPeopleResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'totalPages': instance.totalPages,
      'totalResults': instance.totalResults,
    };
