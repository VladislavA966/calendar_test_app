import 'package:calendar_test_app/core/recources/dimensions.dart';
import 'package:calendar_test_app/features/events/presentation/cubit/events_cubit.dart';
import 'package:calendar_test_app/features/events/presentation/view_model/events_view_model.dart';
import 'package:calendar_test_app/features/events/presentation/widgets/app_text_field.dart';
import 'package:calendar_test_app/features/events/presentation/widgets/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late final TextEditingController _startDateController;
  late final TextEditingController _endDateController;
  late final EventsViewModel viewModel;

  @override
  void initState() {
    super.initState();
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
    viewModel = EventsViewModel(
      context: context,
      startController: _startDateController,
      endController: _endDateController,
      isMounted: () => mounted,
    );
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.unit,
            vertical: Dimensions.unit1_5,
          ),
          child: Column(
            spacing: Dimensions.unit1_5,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                hintText: 'Start date',
                controller: _startDateController,
                onTap: () => viewModel.pickDate(isStartDate: true),
                onSuffixTapped: () => viewModel.onClearDate(isStartDate: true),
              ),
              AppTextField(
                hintText: 'End date',
                controller: _endDateController,
                onTap: () => viewModel.pickDate(isStartDate: false),
                onSuffixTapped: () => viewModel.onClearDate(isStartDate: false),
              ),
              ElevatedButton(
                onPressed: viewModel.onSearch,
                child: const Text('Search'),
              ),
              Divider(),
              BlocConsumer<EventsCubit, EventsState>(
                listener: _listener,
                builder: (context, state) {
                  if (state is EventsLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is EventsLoaded) {
                    final events = state.events;
                    if (events.isEmpty) {
                      return Text('List of Events is empty');
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final event = events[index];
                          return EventTile(event: event);
                        },
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, EventsState state) {
    if (state is EventsError) {
      viewModel.showErrorDialog(state.failure.message);
    }
  }
}
