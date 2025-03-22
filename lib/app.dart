import 'package:calendar_test_app/core/di/inject.dart';
import 'package:calendar_test_app/features/events/domain/use_case/fetch_events_use_case.dart';
import 'package:calendar_test_app/features/events/presentation/cubit/events_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/events/presentation/screens/events_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventsCubit(
        inject<FetchEventsUseCase>(),
      ),
      child: MaterialApp(
        home: const EventsScreen(),
      ),
    );
  }
}


