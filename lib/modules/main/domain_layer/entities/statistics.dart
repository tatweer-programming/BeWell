import 'package:BeWell/modules/main/data_layer/models/quiz_model.dart';
import 'package:equatable/equatable.dart';

//ignore: must_be_immutable
class Statistics extends Equatable {
  final String sectionName;
  QuizModel? quiz;
  Statistics({
    this.quiz,
    required this.sectionName
  });
  @override
  List<Object?> get props => [sectionName];
}
