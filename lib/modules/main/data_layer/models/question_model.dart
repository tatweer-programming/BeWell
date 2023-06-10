
import 'package:BeWell/modules/main/domain_layer/entities/question.dart';

class QuestionModel extends Question {
  const QuestionModel({required super.question, required
  super.trueAnswer, super.explanation , required super.answers , });

  static Question fromJson(Map<String, dynamic> json) {

   return Question(
       question:
       json['question'], trueAnswer: json['trueAnswer'], explanation: json['explanation'], answers:
    List.from(json['answers']).map((e) => e.toString()).toList(),

   ) ;
  }
}
