import 'package:dartz/dartz.dart';
import 'package:reminderapp_test/features/home/data/datasources/exception/data_exception.dart';
import 'package:reminderapp_test/features/home/data/datasources/exception/failure_exception.dart';
import 'package:reminderapp_test/features/home/data/datasources/local/home_local_data_source.dart';
import 'package:reminderapp_test/features/home/data/models/reminder_db_model.dart';
import 'package:reminderapp_test/features/home/domain/entities/reminder.dart';
import 'package:reminderapp_test/features/home/domain/repositories/reminder_reposotory.dart';

class ReminderRepositoryImpl implements ReminderRepository {
  final HomeLocalDataSource remoteDataSource;

  ReminderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ReminderEntity>> localFetchAllData() async {
    dynamic result;
    try {
      result = await remoteDataSource.localFetchAllData();

      return Right(result.baseEntity());
    } on DataException {
      return const Left(DatabaseFailure("Error get data from database"));
    }
  }

  @override
  Future<Either<Failure, ReminderEntity>> localInsertData(
      Reminder reminder) async {
    dynamic result;
    try {
      result = await remoteDataSource.localInsertData(reminder);

      return Right(result.baseEntity());
    } on DataException {
      return const Left(DatabaseFailure("Error get data from database"));
    }
  }

  @override
  Future<Either<Failure, ReminderEntity>> localUpdateData(
      ReminderLocalModel reminder) async {
    dynamic result;
    try {
      result = await remoteDataSource.localUpdateData(reminder);

      return Right(result.baseEntity());
    } on DataException {
      return const Left(DatabaseFailure("Error get data from database"));
    }
  }

  @override
  Future<Either<Failure, ReminderEntity>> localDeleteData(int id) async {
    dynamic result;
    try {
      result = await remoteDataSource.localDeleteData(id);

      return Right(result.baseEntity());
    } on DataException {
      return const Left(DatabaseFailure("Error get data from database"));
    }
  }
}
