import 'package:calendar_test_app/core/di/di_container.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

/// dart run build_runner build --delete-conflicting-outputs
@InjectableInit(preferRelativeImports: true)
Future<GetIt> initDi() async => getIt.init();
