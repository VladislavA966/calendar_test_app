import 'dart:io';
import 'package:calendar_test_app/core/constants/code_responces.dart';
import 'package:calendar_test_app/core/constants/network_constants.dart';
import 'package:calendar_test_app/core/error/exception_handler.dart';
import 'package:calendar_test_app/core/error/failure.dart';
import 'package:calendar_test_app/features/events/data/data_source/events_data_source.dart';
import 'package:calendar_test_app/features/events/domain/entity/event_params.dart';
import 'package:calendar_test_app/features/events/domain/repository/events_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: EventsRepository)
class EventsRepositoryImpl implements EventsRepository {
  final EventsDataSource _dataSource;
  EventsRepositoryImpl(this._dataSource);
  @override
  Future<Either<Failure, dynamic>> fetchEvents(EventParams params) async {
    final connection = await Connectivity().checkConnectivity();
    if (connection == [ConnectivityResult.none]) {
      return Left(
        const NetworkFailure(
          ResponseCode.noInternetConnection,
          strNoInternetError,
        ),
      );
    }
    try {
      final httpResponse = await _dataSource.fetchEvents(
          '2025-03-04T00:00:00', '2025-03-11T00:00:00');
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return Right(httpResponse.response.data);
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
