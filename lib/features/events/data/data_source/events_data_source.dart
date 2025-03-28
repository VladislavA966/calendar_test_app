import 'package:calendar_test_app/features/events/data/model/event_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'events_data_source.g.dart';

@RestApi()
@singleton
abstract class EventsDataSource {
  @factoryMethod
  factory EventsDataSource(Dio dio) = _EventsDataSource;
  @GET('/api/test-task')
  Future<HttpResponse<List<EventModel>>> fetchEvents(
    @Query('start_date') String startDate,
    @Query('end_date') String? endDate,
  );
}
