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
