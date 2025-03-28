part of 'events_cubit.dart';

sealed class EventsState extends Equatable {
  const EventsState();
}

final class EventsInitial extends EventsState {
  @override
  List<Object> get props => [];
}

final class EventsLoading extends EventsState {
  @override
  List<Object?> get props => [];
}

final class EventsLoaded extends EventsState {
  final List<EventEntity> events;

  const EventsLoaded({required this.events});
  @override
  List<Object?> get props => [events];
}

final class EventsError extends EventsState {
  final Failure failure;

  const EventsError({required this.failure});
  @override
  List<Object?> get props => [failure];
}
