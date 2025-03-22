import 'package:calendar_test_app/core/mapper/mapper.dart';
import 'package:calendar_test_app/features/events/data/model/event_model.dart';
import 'package:calendar_test_app/features/events/domain/entity/event_entity.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EventModelToEntityMapper implements BaseMapper<EventModel, EventEntity> {
  @override
  EventEntity map(EventModel from) {
    return EventEntity(
      eventName: from.eventName ?? '',
      description: from.description ?? '',
      date: from.date ?? '',
    );
  }
}
