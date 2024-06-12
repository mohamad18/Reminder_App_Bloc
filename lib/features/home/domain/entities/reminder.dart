import 'package:equatable/equatable.dart';
import 'package:reminderapp_test/features/home/data/models/reminder_db_model.dart';

class ReminderEntity extends Equatable {
  final int? code;
  final List<ReminderLocalModel> data;

  const ReminderEntity({
    required this.code,
    required this.data,
  });

  @override
  List<Object?> get props => [code, data];
}

class Reminder extends Equatable {
  final String title;
  final String description;
  final int hour;
  final int minute;

  const Reminder({
    required this.title,
    required this.description,
    required this.hour,
    required this.minute,
  });

  @override
  List<Object?> get props => [title, description, hour, minute];
}
