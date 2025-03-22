import 'package:calendar_test_app/core/error/failure.dart';
import 'package:calendar_test_app/features/events/domain/entity/event_params.dart';
import 'package:dartz/dartz.dart';

abstract interface class EventsRepository {
  Future<Either<Failure, void>> fetchEvents(EventParams params);
}
