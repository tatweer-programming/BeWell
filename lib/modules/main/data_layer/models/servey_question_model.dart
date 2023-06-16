import 'package:BeWell/modules/main/domain_layer/entities/survey_question.dart';

class SurveyQuestionModel extends SurveyQuestion {
  const SurveyQuestionModel(
      {required super.question,
      required super.maxAnswer,
      required super.minAnswer});

  factory SurveyQuestionModel.fromJson(Map<String, dynamic> json) {
    return SurveyQuestionModel(
      question: json['question'],
      maxAnswer: json['maxAnswer'],
      minAnswer: json['minAnswer'],
    );
  }
}
