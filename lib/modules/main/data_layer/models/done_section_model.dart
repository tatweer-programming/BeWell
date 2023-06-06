
import '../../domain_layer/entities/done_section.dart';

class DoneSectionModel extends DoneSection{
  const DoneSectionModel({
    required super.studentName,
    required super.done,
    required super.lastUsing,
    required super.progress,
  });
  factory DoneSectionModel.fromJson(Map<String, dynamic> json) =>
      DoneSectionModel(
        studentName: json['studentName'],
        lastUsing: json['lastUsing'],
        progress: Map<String,double>.from(json["progress"]),
        done: Map<String,int>.from(json["done"]),
      );

  Map<String, dynamic> toJson() {
    return {
      "studentName":studentName,
      "lastUsing": lastUsing,
      "done": done,
      "progress":progress
    };
  }
}
