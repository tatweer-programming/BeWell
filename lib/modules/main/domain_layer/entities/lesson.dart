import 'package:equatable/equatable.dart';
import 'package:BeWell/modules/main/data_layer/models/section_model.dart';

class Lesson extends Equatable {
  final List<SectionsModel> sections;
  const Lesson({
    required this.sections,
  });
  @override
  List<Object?> get props => [sections];
}
