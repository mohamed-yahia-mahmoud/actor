// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetPersonImagesResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPersonImagesResponse _$GetPersonImagesResponseFromJson(
        Map<String, dynamic> json) =>
    GetPersonImagesResponse(
      id: json['id'] as int?,
      profiles: (json['profiles'] as List<dynamic>?)
          ?.map((e) => Profiles.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPersonImagesResponseToJson(
        GetPersonImagesResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profiles': instance.profiles,
    };
