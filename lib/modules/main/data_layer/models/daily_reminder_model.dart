import 'package:BeWell/modules/main/data_layer/models/section_model.dart';

import '../../domain_layer/entities/daily_reminder.dart';

class DailyReminderModel extends DailyReminder {
  const DailyReminderModel({
    required super.image,
    required super.title,
  });
  factory DailyReminderModel.fromJson(Map<String, dynamic> json) => DailyReminderModel(
    image: json["image"],
    title: json["title"]
  );
}
