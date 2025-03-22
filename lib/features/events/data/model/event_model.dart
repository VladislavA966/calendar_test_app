import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel {
  @JsonKey(name: 'event_name')
  final String? eventName;
  final String? description;
  final String? date;

  EventModel({
    required this.eventName,
    required this.description,
    required this.date,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
