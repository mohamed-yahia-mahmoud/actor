// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetPersonDetailsRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPersonDetailsRequest _$GetPersonDetailsRequestFromJson(
        Map<String, dynamic> json) =>
    GetPersonDetailsRequest(
      api_key: json['api_key'] as String?,
      language: json['language'] as String?,
    );

Map<String, dynamic> _$GetPersonDetailsRequestToJson(
        GetPersonDetailsRequest instance) =>
    <String, dynamic>{
      'api_key': instance.api_key,
      'language': instance.language,
    };
