//import 'dart:js_interop';

import 'package:BeWell/modules/main/domain_layer/entities/question.dart';
import 'package:equatable/equatable.dart';
import 'package:BeWell/modules/main/data_layer/models/question_model.dart';

//ignore: must_be_immutable
class Quiz extends Equatable {
  List<Question> questions;

  Quiz(
      {

      required this.questions ,
      });
  @override
  List<Object?> get props => [questions, ];
}
