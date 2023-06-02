import '../../domain_layer/entities/course.dart';
import 'lesson_model.dart';

class CourseModel extends Course{
  const CourseModel({
    required super.courseName,
    required super.courseImage,
    required super.lessons,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      CourseModel(
        courseName: json['courseName'],
        courseImage: json['courseImage'],
        lessons: List.from(json["lessons"]).map((e) => LessonModel.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() {
    return {
      "courseName": courseName,
      "courseImage":courseImage,
      "examsIds":lessons.map((e) => e.toJson()).toList(),
    };
  }
}
