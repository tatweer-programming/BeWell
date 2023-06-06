import 'package:BeWell/modules/main/domain_layer/entities/question.dart';

class QuestionModel extends Question {
  QuestionModel({required super.answers, required super.question, required super.trueAnswer});

 factory QuestionModel.fromJson(Map<String, dynamic> json){
     return QuestionModel(answers: List.from(json['answers']).map((e) => e.toString()).toList(), question:  json['question'],
         trueAnswer: json['trueAnswer']);
   }

}