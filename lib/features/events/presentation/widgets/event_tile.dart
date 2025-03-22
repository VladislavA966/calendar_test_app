import 'package:calendar_test_app/core/recources/dimensions.dart';
import 'package:calendar_test_app/features/events/domain/entity/event_entity.dart';
import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
  final EventEntity event;

  const EventTile({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(event.eventName),
      subtitle: Text(event.description),
      trailing: Text(event.date),
      isThreeLine: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Dimensions.unit1_5,
        vertical: Dimensions.unit,
      ),
    );
  }
}
