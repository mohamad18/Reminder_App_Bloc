import 'package:reminderapp_test/features/home/domain/entities/reminder.dart';

class BaseResponse {
  int? code;
  dynamic data;

  BaseResponse({
    required this.code,
    this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        code: json['code'],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        'data': data,
      };

  ReminderEntity baseEntity() => ReminderEntity(
        code: code,
        data: data != null ? data : [],
      );
}
