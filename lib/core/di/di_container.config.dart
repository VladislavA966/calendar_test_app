// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/events/data/data_source/events_data_source.dart'
    as _i1020;
import '../../features/events/data/mappers/event_mapper.dart' as _i431;
import '../../features/events/data/repository_impl/events_repository_impl.dart'
    as _i122;
import '../../features/events/domain/repository/events_repository.dart'
    as _i161;
import '../../features/events/domain/use_case/fetch_events_use_case.dart'
    as _i466;
import '../dio/dio_module.dart' as _i977;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.singleton<_i361.Dio>(() => dioModule.baseModule());
    gh.lazySingleton<_i431.EventModelToEntityMapper>(
        () => _i431.EventModelToEntityMapper());
    gh.singleton<_i1020.EventsDataSource>(
        () => _i1020.EventsDataSource(gh<_i361.Dio>()));
    gh.singleton<_i161.EventsRepository>(() => _i122.EventsRepositoryImpl(
          gh<_i1020.EventsDataSource>(),
          gh<_i431.EventModelToEntityMapper>(),
        ));
    gh.singleton<_i466.FetchEventsUseCase>(
        () => _i466.FetchEventsUseCase(gh<_i161.EventsRepository>()));
    return this;
  }
}

class _$DioModule extends _i977.DioModule {}
