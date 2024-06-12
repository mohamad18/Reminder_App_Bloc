class ReminderLocalModel {
  final int id;
  final String title;
  final String description;
  final int hour;
  final int minute;

  ReminderLocalModel({
    required this.id,
    required this.title,
    required this.description,
    required this.hour,
    required this.minute,
  });

  factory ReminderLocalModel.fromData({required Map data}) {
    return ReminderLocalModel(
      id: data["id"],
      title: data["title"],
      description: data["description"],
      hour: data["hour"],
      minute: data["minute"],
    );
  }
}
