import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminderapp_test/features/home/presentation/bloc/home_bloc.dart';

deleteReminder({required int idReminder, required BuildContext context}) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Delete Reminder"),
        content: const Text(
          "Are you sure want to Delete?",
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<HomeBloc>().add(DeleteDataReminderEvent(idReminder));
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      );
    },
  );
}
