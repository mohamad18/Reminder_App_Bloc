import 'package:dartz/dartz.dart';
import 'package:reminderapp_test/features/home/data/datasources/exception/failure_exception.dart';
import 'package:reminderapp_test/features/home/data/models/reminder_db_model.dart';
import 'package:reminderapp_test/features/home/domain/entities/reminder.dart';
import 'package:reminderapp_test/features/home/domain/repositories/reminder_reposotory.dart';

class UpdateDataReminderUsecase {
  final ReminderRepository repository;

  UpdateDataReminderUsecase(this.repository);

  Future<Either<Failure, ReminderEntity>> execute(ReminderLocalModel reminder) {
    return repository.localUpdateData(reminder);
  }
}
