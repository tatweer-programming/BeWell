import 'package:equatable/equatable.dart';
import 'package:BeWell/modules/main/data_layer/models/section_model.dart';
import 'package:BeWell/modules/main/domain_layer/entities/section.dart';

class Lesson extends Equatable {
  final String lessonName;
  final List<SectionsModel> sections;
  const Lesson({
    required this.lessonName,
    required this.sections,
  });
  @override
  List<Object?> get props => [lessonName, sections];
}
