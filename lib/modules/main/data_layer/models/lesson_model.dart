import 'package:BeWell/modules/main/data_layer/models/section_model.dart';

import '../../domain_layer/entities/lesson.dart';

class LessonModel extends Lesson {
  const LessonModel({
    required super.sections,
  });
  factory LessonModel.fromJson(Map<String, dynamic> json) => LessonModel(
        sections: List.from(json["sections"])
            .map((e) => SectionsModel.fromJson(e))
            .toList(),
      );

}
