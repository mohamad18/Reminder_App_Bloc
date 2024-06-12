import 'package:dartz/dartz.dart';
import 'package:reminderapp_test/features/home/data/datasources/exception/failure_exception.dart';
import 'package:reminderapp_test/features/home/domain/entities/reminder.dart';
import 'package:reminderapp_test/features/home/domain/repositories/reminder_reposotory.dart';

class InsertDataReminderUsecase {
  final ReminderRepository repository;

  InsertDataReminderUsecase(this.repository);

  Future<Either<Failure, ReminderEntity>> execute(Reminder reminder) {
    return repository.localInsertData(reminder);
  }
}
