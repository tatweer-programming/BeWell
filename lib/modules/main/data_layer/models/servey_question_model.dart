import 'dart:convert';

import 'package:BeWell/modules/main/domain_layer/entities/survey_question.dart';

class SurveyQuestionModel extends SurveyQuestion
{
  const SurveyQuestionModel({required super.question, required super.maxAnswer ,});

  static SurveyQuestion fromJson (Map <String , dynamic> json){
   return SurveyQuestion(question: json['question'],
       maxAnswer: json['maxAnswer'],minAnswer: json['minAnswer'],);
}
}