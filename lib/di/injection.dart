import 'package:get_it/get_it.dart';
import 'package:reminderapp_test/cores/local_db/db_helper.dart';
import 'package:reminderapp_test/features/home/data/datasources/local/home_local_data_source.dart';
import 'package:reminderapp_test/features/home/data/repositories/reminder_repositories_impl.dart';
import 'package:reminderapp_test/features/home/domain/repositories/reminder_reposotory.dart';
import 'package:reminderapp_test/features/home/domain/usecases/delete_data_reminder_usecase.dart';
import 'package:reminderapp_test/features/home/domain/usecases/get_data_reminder_usecase.dart';
import 'package:reminderapp_test/features/home/domain/usecases/insert_data_reminder_usecase.dart';
import 'package:reminderapp_test/features/home/domain/usecases/update_data_reminder_usecase.dart';
import 'package:reminderapp_test/features/home/presentation/bloc/home_bloc.dart';

final locator = GetIt.instance;

void init() async {
  // ============= Start init reminder =================
  // section register getit bloc
  // section register getit usecase
  // section register getit repository
  // section register getit datasource
  locator.registerFactory(
      () => HomeBloc(locator(), locator(), locator(), locator()));
  locator.registerLazySingleton<ReminderRepository>(
      () => ReminderRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<HomeLocalDataSource>(
      () => HomeLocalDataSourceImpl(database: locator()));
  locator.registerLazySingleton(() => DBHelper.dbHelper);
  locator.registerLazySingleton(() => GetListReminderUsecase(locator()));
  locator.registerLazySingleton(() => InsertDataReminderUsecase(locator()));
  locator.registerLazySingleton(() => UpdateDataReminderUsecase(locator()));
  locator.registerLazySingleton(() => DeleteDataReminderUsecase(locator()));
  // ============= End init reminder =================
}
