import 'package:json_annotation/json_annotation.dart';
part 'GetPopularPeopleRequest.g.dart';
@JsonSerializable()
class GetPopularPeopleRequest {
  String? api_key;
  String?language;
  int?page;

  GetPopularPeopleRequest({this.api_key,this.language, this.page});

  factory GetPopularPeopleRequest.fromJson(Map<String, dynamic> json) =>
      _$GetPopularPeopleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetPopularPeopleRequestToJson(this);
}