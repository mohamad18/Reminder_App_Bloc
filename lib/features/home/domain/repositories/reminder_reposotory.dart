import 'package:dartz/dartz.dart';
import 'package:reminderapp_test/features/home/data/datasources/exception/failure_exception.dart';
import 'package:reminderapp_test/features/home/data/models/reminder_db_model.dart';
import 'package:reminderapp_test/features/home/domain/entities/reminder.dart';

abstract class ReminderRepository {
  Future<Either<Failure, ReminderEntity>> localFetchAllData();
  Future<Either<Failure, ReminderEntity>> localInsertData(Reminder reminder);
  Future<Either<Failure, ReminderEntity>> localUpdateData(
      ReminderLocalModel reminder);
  Future<Either<Failure, ReminderEntity>> localDeleteData(int id);
}
