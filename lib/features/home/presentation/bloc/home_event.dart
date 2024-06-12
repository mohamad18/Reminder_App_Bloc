part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class ChangeThemeEvent extends HomeEvent {
  const ChangeThemeEvent();
}

class GetListReminderEvent extends HomeEvent {
  const GetListReminderEvent();
}

class InsertDataReminderEvent extends HomeEvent {
  const InsertDataReminderEvent(this.data);

  final Reminder data;
}

class UpdateDataReminderEvent extends HomeEvent {
  const UpdateDataReminderEvent(this.data);

  final ReminderLocalModel data;
}

class DeleteDataReminderEvent extends HomeEvent {
  const DeleteDataReminderEvent(this.id);

  final int id;
}

class SetDateTimeEvent extends HomeEvent {
  const SetDateTimeEvent(this.hourVal, this.minuteVal);

  final int hourVal;
  final int minuteVal;
}

class ClearDateTimeEvent extends HomeEvent {
  const ClearDateTimeEvent();
}
