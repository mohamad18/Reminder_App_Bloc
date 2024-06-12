part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool loading;
  final bool? loaded;
  final bool isDarkMode;
  final List<ReminderLocalModel>? dataReminder;
  final int year;
  final int month;
  final int day;
  final int hour;
  final int minute;

  const HomeState({
    this.loading = false,
    this.loaded,
    this.isDarkMode = false,
    this.dataReminder,
    this.year = 0,
    this.month = 0,
    this.day = 0,
    this.hour = 0,
    this.minute = 0,
  });

  HomeState copywith({
    bool? loading = false,
    bool? loaded,
    bool? isDarkMode,
    List<ReminderLocalModel>? dataReminder,
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
  }) {
    return HomeState(
      loading: loading ?? this.loading,
      loaded: loaded ?? this.loaded,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      dataReminder: dataReminder ?? this.dataReminder,
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        loaded,
        isDarkMode,
        dataReminder,
        year,
        month,
        day,
        hour,
        minute,
      ];

  get getTheme => isDarkMode ? lightTheme() : darkTheme();
  get getModeIcon => isDarkMode ? lightIcon() : darkIcon();
}
