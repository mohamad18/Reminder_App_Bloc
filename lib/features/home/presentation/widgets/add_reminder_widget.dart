import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminderapp_test/cores/local_notification/notification_helper.dart';
import 'package:reminderapp_test/features/home/domain/entities/reminder.dart';
import 'package:reminderapp_test/features/home/presentation/bloc/home_bloc.dart';
import 'package:reminderapp_test/features/home/presentation/widgets/text_field_decoration_widget.dart';

addReminder(context) {
  final key = GlobalKey<FormState>();
  String title = "";
  String description = "";

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              "Add Reminder",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            content: Form(
              key: key,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      autofocus: true,
                      decoration: textFiledDecoration(
                          label: "Title", hint: "Enter reminder title"),
                      validator: (val) =>
                          (val!.isEmpty) ? "Enter ritle first" : null,
                      onSaved: (val) {
                        title = val!;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: textFiledDecoration(
                          label: "Description", hint: "Enter description"),
                      validator: (val) =>
                          (val!.isEmpty) ? "Enter description first" : null,
                      onSaved: (val) {
                        description = val!;
                      },
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            dateTimePicker(context);
                          },
                          icon: const Icon(Icons.watch_later_outlined),
                        ),
                        Expanded(
                          child: (state.hour != 0)
                              ? Text(
                                  "${(state.hour > 12) ? state.hour - 12 : state.hour}:${state.minute} ${(state.hour > 12) ? "PM" : "AM"}",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                )
                              : const Text(""),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
                  if (key.currentState!.validate()) {
                    key.currentState!.save();

                    if (state.hour != 0) {
                      Reminder reminderEntity = Reminder(
                        title: title,
                        description: description,
                        hour: state.hour,
                        minute: state.minute,
                      );
                      NotificationHelper.notificationHelper
                          .scheduleNotification(reminder: reminderEntity);
                      context
                          .read<HomeBloc>()
                          .add(InsertDataReminderEvent(reminderEntity));
                      context.read<HomeBloc>().add(ClearDateTimeEvent());
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text("Save"),
              ),
            ],
          );
        },
      );
    },
  );
}

dateTimePicker(BuildContext context) {
  showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  ).then((TimeOfDay? value1) {
    if (value1 != null) {
      context
          .read<HomeBloc>()
          .add(SetDateTimeEvent(value1.hour, value1.minute));
    }
  });
}
