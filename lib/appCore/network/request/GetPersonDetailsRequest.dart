import 'package:json_annotation/json_annotation.dart';
part 'GetPersonDetailsRequest.g.dart';
@JsonSerializable()
class GetPersonDetailsRequest {
  String? api_key;
  String?language;


  GetPersonDetailsRequest({this.api_key,this.language });

  factory GetPersonDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$GetPersonDetailsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetPersonDetailsRequestToJson(this);
}