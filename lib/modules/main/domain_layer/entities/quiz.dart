//import 'dart:js_interop';

import 'package:BeWell/modules/main/domain_layer/entities/question.dart';
import 'package:equatable/equatable.dart';
import 'package:BeWell/modules/main/data_layer/models/question_model.dart';

//ignore: must_be_immutable
class Quiz extends Equatable {
  List<Question> questions;
  int totalMarks;
  int collectedMarks;
  Quiz(
      {
        required this.questions,
        this.collectedMarks = 0,
        required this.totalMarks});
  @override
  List<Object?> get props => [totalMarks, questions];
}
