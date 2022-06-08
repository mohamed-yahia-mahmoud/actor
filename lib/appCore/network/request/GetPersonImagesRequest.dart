import 'package:json_annotation/json_annotation.dart';
part 'GetPersonImagesRequest.g.dart';
@JsonSerializable()
class GetPersonImagesRequest {
  String? api_key;



  GetPersonImagesRequest({this.api_key, });

  factory GetPersonImagesRequest.fromJson(Map<String, dynamic> json) =>
      _$GetPersonImagesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetPersonImagesRequestToJson(this);
}