import 'package:calendar_test_app/core/error/failure.dart';
import 'package:calendar_test_app/core/use_case/base_use_case.dart';
import 'package:calendar_test_app/features/events/domain/entity/event_params.dart';
import 'package:calendar_test_app/features/events/domain/repository/events_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
final class FetchEventsUseCase extends UseCase<void, EventParams> {
  final EventsRepository _repository;
  FetchEventsUseCase(this._repository);
  @override
  Future<Either<Failure, void>> call(params) async {
    return await _repository.fetchEvents(params);
  }
}
