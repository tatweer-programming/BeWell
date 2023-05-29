import 'package:equatable/equatable.dart';
import 'package:BeWell/modules/main/data_layer/models/lesson_model.dart';
import 'lesson.dart';

class Course extends Equatable{
  final List<LessonModel> lessons;
  final String courseName;
  final String courseImage;
  const Course({
    required this.lessons,
    required this.courseName,
    required this.courseImage,
  });
  @override
  List<Object?> get props => [lessons,courseName,courseImage];
}
