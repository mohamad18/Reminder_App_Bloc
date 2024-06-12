import 'package:reminderapp_test/cores/local_db/db_helper.dart';
import 'package:reminderapp_test/features/home/data/datasources/exception/data_exception.dart';
import 'package:reminderapp_test/features/home/data/datasources/exception/error_code.dart';
import 'package:reminderapp_test/features/home/data/models/base_response.dart';
import 'package:reminderapp_test/features/home/data/models/reminder_db_model.dart';
import 'package:reminderapp_test/features/home/domain/entities/reminder.dart';

abstract class HomeLocalDataSource {
  Future<BaseResponse> localFetchAllData();
  Future<BaseResponse> localInsertData(Reminder reminder);
  Future<BaseResponse> localUpdateData(ReminderLocalModel reminder);
  Future<BaseResponse> localDeleteData(int id);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  DBHelper database;

  HomeLocalDataSourceImpl({required this.database}) {
    database = DBHelper.dbHelper;
  }

  @override
  Future<BaseResponse> localFetchAllData() async {
    try {
      final res = await database.fetchAllRecords();

      return BaseResponse(code: 200, data: res);
    } on DataException {
      return BaseResponse(
        code: ErrorCodes.DATA_ERROR,
        data: null,
      );
    }
  }

  @override
  Future<BaseResponse> localInsertData(Reminder reminder) async {
    try {
      final res = await database.insertRecord(reminder: reminder);

      return BaseResponse(code: 200, data: res);
    } on DataException {
      return BaseResponse(
        data: null,
        code: ErrorCodes.DATA_ERROR,
      );
    }
  }

  @override
  Future<BaseResponse> localUpdateData(ReminderLocalModel reminder) async {
    try {
      final res = await database.updateReminder(reminder: reminder);

      return BaseResponse(code: 200, data: res);
    } on DataException {
      return BaseResponse(
        data: null,
        code: ErrorCodes.DATA_ERROR,
      );
    }
  }

  @override
  Future<BaseResponse> localDeleteData(int id) async {
    try {
      final res = await database.deleteReminder(id: id);

      return BaseResponse(code: 200, data: res);
    } on DataException {
      return BaseResponse(
        data: null,
        code: ErrorCodes.DATA_ERROR,
      );
    }
  }
}
