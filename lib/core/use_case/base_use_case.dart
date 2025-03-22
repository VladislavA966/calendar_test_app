import 'package:calendar_test_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract base class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
