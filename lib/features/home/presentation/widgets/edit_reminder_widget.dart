import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminderapp_test/cores/local_notification/notification_helper.dart';
import 'package:reminderapp_test/features/home/data/models/reminder_db_model.dart';
import 'package:reminderapp_test/features/home/domain/entities/reminder.dart';
import 'package:reminderapp_test/features/home/presentation/bloc/home_bloc.dart';
import 'package:reminderapp_test/features/home/presentation/widgets/text_field_decoration_widget.dart';

editReminder(
    {required ReminderLocalModel reminder,
    required BuildContext context}) async {
  final key = GlobalKey<FormState>();
  String title = "";
  String description = "";

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  context.read<HomeBloc>().add(SetDateTimeEvent(
        reminder.hour,
        reminder.minute,
      ));

  titleController.text = reminder.title;
  descController.text = reminder.description;

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
            title: const Text("Update Reminder"),
            content: Form(
              key: key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: titleController,
                    decoration: textFiledDecoration(
                        label: "Title", hint: "Enter reminder title"),
                    validator: (val) =>
                        (val!.isEmpty) ? "Enter title first" : null,
                    onSaved: (val) {
                      title = val!;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: descController,
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
                          dateTimePickerEdit(context, state);
                        },
                        icon: const Icon(Icons.watch_later_outlined),
                      ),
                      Expanded(
                        child: (state.hour != 0)
                            ? Text(
                                "${(state.hour > 12) ? state.hour - 12 : state.hour}:${state.minute} ${(state.hour > 12) ? "PM" : "AM"}",
                                style: Theme.of(context).textTheme.titleMedium)
                            : const Text(""),
                      ),
                    ],
                  ),
                ],
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
                      ReminderLocalModel reminderLocalModel =
                          ReminderLocalModel(
                        id: reminder.id,
                        title: title,
                        description: description,
                        hour: state.hour,
                        minute: state.minute,
                      );

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
                          .add(UpdateDataReminderEvent(reminderLocalModel));
                      context.read<HomeBloc>().add(ClearDateTimeEvent());
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text("Update"),
              ),
            ],
          );
        },
      );
    },
  );
}

dateTimePickerEdit(BuildContext context, state) {
  showTimePicker(
    context: context,
    initialTime: TimeOfDay(minute: state.minute, hour: state.hour),
  ).then((TimeOfDay? value1) {
    if (value1 != null) {
      context
          .read<HomeBloc>()
          .add(SetDateTimeEvent(value1.hour, value1.minute));
    }
  });
}
