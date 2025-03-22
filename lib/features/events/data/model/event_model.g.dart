// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      eventName: json['event_name'] as String?,
      description: json['description'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'event_name': instance.eventName,
      'description': instance.description,
      'date': instance.date,
    };
