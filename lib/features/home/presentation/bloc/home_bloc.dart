import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reminderapp_test/features/home/data/models/reminder_db_model.dart';
import 'package:reminderapp_test/features/home/domain/entities/reminder.dart';
import 'package:reminderapp_test/features/home/domain/usecases/delete_data_reminder_usecase.dart';
import 'package:reminderapp_test/features/home/domain/usecases/get_data_reminder_usecase.dart';
import 'package:reminderapp_test/features/home/domain/usecases/insert_data_reminder_usecase.dart';
import 'package:reminderapp_test/features/home/domain/usecases/update_data_reminder_usecase.dart';
import 'package:reminderapp_test/utils/theme.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetListReminderUsecase _getListReminder;
  final InsertDataReminderUsecase _insertDataReminder;
  final UpdateDataReminderUsecase _updateDataReminder;
  final DeleteDataReminderUsecase _deleteDataReminder;

  HomeBloc(
    this._getListReminder,
    this._insertDataReminder,
    this._updateDataReminder,
    this._deleteDataReminder,
  ) : super(HomeState()) {
    on<ChangeThemeEvent>(_onChangeTheme);
    on<SetDateTimeEvent>(_onSetDateTime);
    on<ClearDateTimeEvent>(_onClearDateTime);
    on<GetListReminderEvent>(_onGetListReminder);
    on<InsertDataReminderEvent>(_onInsertDataReminder);
    on<UpdateDataReminderEvent>(_onUpdateDataReminder);
    on<DeleteDataReminderEvent>(_onDeleteDataReminder);
  }

  _onChangeTheme(ChangeThemeEvent event, Emitter<HomeState> emit) async {
    bool theme = !state.isDarkMode;

    emit(state.copywith(isDarkMode: theme));
  }

  _onSetDateTime(SetDateTimeEvent event, Emitter<HomeState> emit) async {
    emit(state.copywith(hour: event.hourVal, minute: event.minuteVal));
  }

  _onClearDateTime(ClearDateTimeEvent event, Emitter<HomeState> emit) async {
    emit(state.copywith(hour: 0, minute: 0));
  }

  _onGetListReminder(
      GetListReminderEvent event, Emitter<HomeState> emit) async {
    emit(state.copywith(loading: false));

    print("===============>>>>>>>>>>>>>> _onGetListReminder");

    final res = await _getListReminder.execute();

    res.fold((failure) {
      print(failure.message);
    }, (result) {
      emit(state.copywith(loading: true, dataReminder: result.data));
    });
  }

  _onInsertDataReminder(
      InsertDataReminderEvent event, Emitter<HomeState> emit) async {
    emit(state.copywith(loading: false));

    print("===============>>>>>>>>>>>>>> _onInsertDataReminder");

    final res = await _insertDataReminder.execute(event.data);

    res.fold((failure) {
      print(failure.message);
    }, (result) {
      // sort data
      result.data.sort((a, b) {
        int minute = (a.minute > 9) ? a.minute : int.parse("0${a.minute}");
        int minute2 = (b.minute > 9) ? b.minute : int.parse("0${b.minute}");

        return (int.parse("${a.hour}$minute"))
            .compareTo(int.parse("${b.hour}$minute2"));
      });
      emit(state.copywith(loading: true, dataReminder: result.data));
    });
  }

  _onUpdateDataReminder(
      UpdateDataReminderEvent event, Emitter<HomeState> emit) async {
    emit(state.copywith(loading: false));

    print("===============>>>>>>>>>>>>>> _onUpdateDataReminder");

    final res = await _updateDataReminder.execute(event.data);

    res.fold((failure) {
      print(failure.message);
    }, (result) {
      emit(state.copywith(loading: true, dataReminder: result.data));
    });
  }

  _onDeleteDataReminder(
      DeleteDataReminderEvent event, Emitter<HomeState> emit) async {
    emit(state.copywith(loading: false));

    print("===============>>>>>>>>>>>>>> _onDeleteDataReminder");

    final res = await _deleteDataReminder.execute(event.id);

    res.fold((failure) {
      print(failure.message);
    }, (result) {
      emit(state.copywith(loading: true, dataReminder: result.data));
    });
  }
}
