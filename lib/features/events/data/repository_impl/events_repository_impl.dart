import 'dart:io';
import 'package:calendar_test_app/core/constants/code_responces.dart';
import 'package:calendar_test_app/core/constants/network_constants.dart';
import 'package:calendar_test_app/core/error/exception_handler.dart';
import 'package:calendar_test_app/core/error/failure.dart';
import 'package:calendar_test_app/core/utils/network_utils.dart';
import 'package:calendar_test_app/features/events/data/data_source/events_data_source.dart';
import 'package:calendar_test_app/features/events/data/mappers/event_mapper.dart';
import 'package:calendar_test_app/features/events/domain/entity/event_entity.dart';
import 'package:calendar_test_app/features/events/domain/entity/event_params.dart';
import 'package:calendar_test_app/features/events/domain/repository/events_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: EventsRepository)
class EventsRepositoryImpl implements EventsRepository {
  final EventsDataSource _dataSource;
  final EventModelToEntityMapper _mapper;
  EventsRepositoryImpl(this._dataSource, this._mapper);
  @override
  Future<Either<Failure, List<EventEntity>>> fetchEvents(
      EventParams params) async {
    if (!await NetworkChecker.hasConnection()) {
      return Left(
        NetworkFailure(
          ResponseCode.noInternetConnection,
          strNoInternetError,
        ),
      );
    }

    try {
      final httpResponse = await _dataSource.fetchEvents(
        params.startDate,
        params.endDate,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final events = (httpResponse.data).map(_mapper.map).toList();
        return Right(events);
      } else {
        return Left(
          ServerFailure(
            httpResponse.response.statusCode ?? ResponseCode.defaultError,
            httpResponse.response.statusMessage ?? strDefaultError,
          ),
        );
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
