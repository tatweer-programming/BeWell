//import 'dart:js_interop';

import 'package:equatable/equatable.dart';
import 'package:BeWell/modules/main/data_layer/models/question_model.dart';

class Quiz extends Equatable {
  List <QuestionModel> questions ;
  int totalMarks ;
  int collectedMarks ;
  Quiz({required this.questions,   this.collectedMarks = 0, required this.totalMarks});
  @override
  List<Object?> get props => [totalMarks , questions];
}