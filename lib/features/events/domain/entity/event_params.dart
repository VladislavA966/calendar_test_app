import 'package:equatable/equatable.dart';

class EventParams extends Equatable {
  final String startDate;
  final String? endDate;

  const EventParams({required this.startDate, this.endDate});

  EventParams copyWith({
    String? startDate,
    String? endDate,
  }) {
    return EventParams(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  List<Object?> get props => [startDate, endDate];
}
