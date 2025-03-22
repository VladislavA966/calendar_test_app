import 'package:bloc/bloc.dart';
import 'package:calendar_test_app/core/error/failure.dart';
import 'package:calendar_test_app/features/events/domain/entity/event_entity.dart';
import 'package:calendar_test_app/features/events/domain/entity/event_params.dart';
import 'package:calendar_test_app/features/events/domain/use_case/fetch_events_use_case.dart';
import 'package:equatable/equatable.dart';

part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  final FetchEventsUseCase _fetchEventsUseCase;
  EventsCubit(this._fetchEventsUseCase) : super(EventsInitial());

  Future<void> fetchEvents(EventParams params) async {
    emit(EventsLoading());
    final result = await _fetchEventsUseCase(params);
    result.fold(
      (failure) => emit(EventsError(failure: failure)),
      (events) => emit(EventsLoaded(events: events)),
    );
  }
}
