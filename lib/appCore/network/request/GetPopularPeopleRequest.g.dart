// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetPopularPeopleRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPopularPeopleRequest _$GetPopularPeopleRequestFromJson(
        Map<String, dynamic> json) =>
    GetPopularPeopleRequest(
      api_key: json['api_key'] as String?,
      language: json['language'] as String?,
      page: json['page'] as int?,
    );

Map<String, dynamic> _$GetPopularPeopleRequestToJson(
        GetPopularPeopleRequest instance) =>
    <String, dynamic>{
      'api_key': instance.api_key,
      'language': instance.language,
      'page': instance.page,
    };
