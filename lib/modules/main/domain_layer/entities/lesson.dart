import 'package:BeWell/modules/main/data_layer/models/course_models.dart';
import 'package:BeWell/modules/main/data_layer/models/lesson_model.dart';
import 'package:equatable/equatable.dart';
import 'package:BeWell/modules/main/data_layer/models/section_model.dart';

class Lesson extends Equatable {
  final List<SectionsModel> sections;
  final String lessonName;
  const Lesson({
    required this.sections,
    required this.lessonName,
  });
  @override
  List<Object?> get props => [sections,lessonName];
}
CourseModel courseModel =  CourseModel(courseName: 'Mental health  الصحة العقلية',
    courseImage: 'https://firebasestorage.googleapis.com/v0/b/bewell-a2eba.appspot.com/o/coursesIcons%2F2D-icons-Design2.jpg?alt=media&token=be0c47a6-7eaa-48c2-9146-070ed4c8bad5',
    lessons:
    [
        LessonModel(
            sections: [
        SectionsModel(sectionName: 'sectionName'),


      ], lessonName: 'lessonName'),
    ],


);