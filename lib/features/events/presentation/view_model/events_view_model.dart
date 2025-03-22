import 'package:calendar_test_app/features/events/domain/entity/event_params.dart';
import 'package:calendar_test_app/features/events/presentation/cubit/events_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EventsViewModel {
  final BuildContext context;
  final TextEditingController startController;
  final TextEditingController endController;
  final bool Function() isMounted;

  EventsViewModel({
    required this.context,
    required this.startController,
    required this.endController,
    required this.isMounted,
  });

  EventParams _params = EventParams(startDate: '');

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void onClearDate({required bool isStartDate}) {
    if (isStartDate) {
      _params = _params.copyWith(startDate: '');
    } else {
      _params = _params.copyWith(endDate: '');
    }
  }

  Future<void> pickDate({required bool isStartDate}) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 4),
      lastDate: DateTime(DateTime.now().year + 4),
    );

    if (pickedDate == null || !isMounted()) return;

    final formattedDisplay = DateFormat('dd.MM.yyyy').format(pickedDate);
    final formattedApi = DateFormat('dd-MM-yyyy').format(pickedDate);

    if (isStartDate) {
      startController.text = formattedDisplay;
      _params = _params.copyWith(startDate: formattedApi);
    } else {
      endController.text = formattedDisplay;
      _params = _params.copyWith(endDate: formattedApi);
    }
  }

  void onSearch() {
    final startText = startController.text;
    final endText = endController.text;

    if (startText.isEmpty) {
      _showError('Start date is required.');
      return;
    }

    if (endText.isNotEmpty) {
      final start = DateFormat('dd.MM.yyyy').parse(startText);
      final end = DateFormat('dd.MM.yyyy').parse(endText);

      if (end.difference(start).inDays < 7) {
        _showError('End date must be exactly 7 days after start date.');
        return;
      }
    }

    context.read<EventsCubit>().fetchEvents(_params);
  }

  Future<dynamic> showErrorDialog(String message) {
    return showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
