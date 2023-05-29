import 'package:BeWell/modules/main/domain_layer/entities/question.dart';

class QuestionModel extends Question {
  QuestionModel({required super.answers, required super.question, required super.trueAnswer});

 factory  QuestionModel.fromJson(Map<String, dynamic> json){
     return QuestionModel(answers: json['answers'] as List<String>, question:  json['question'],
         trueAnswer: json['trueAnswer']);
   }

}