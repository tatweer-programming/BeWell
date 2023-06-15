import 'package:BeWell/modules/main/data_layer/models/daily_reminder_model.dart';
import '../../domain_layer/entities/done_section.dart';

class DoneSectionModel extends DoneSection {
  const DoneSectionModel({
    required super.studentName,
    required super.done,
    required super.lastUsing,
    required super.dailyReminder,
    required super.progress,
  });
  factory DoneSectionModel.fromJson(Map<String, dynamic> json) =>
      DoneSectionModel(
        studentName: json['studentName'],
        lastUsing: json['lastUsing'],
        dailyReminder: List.from(json['dailyReminder'])
            .map((e) => DailyReminderModel.fromJson(e))
            .toList(),
        progress: Map<String, dynamic>.from(json["progress"]),
        done: Map<String, int>.from(json["done"]),
      );

  Map<String, dynamic> toJson() {
    return {
      "studentName": studentName,
      "lastUsing": lastUsing,
      "done": done,
      "progress": progress
    };
  }
}
