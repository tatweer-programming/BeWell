import 'package:BeWell/modules/main/data_layer/models/servey_question_model.dart';
import 'package:BeWell/modules/main/domain_layer/entities/survey.dart';

class SurveyModel extends Survey {
  SurveyModel({
    required super.questions,
    required super.result,
  });

  static Survey? fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return Survey(
        questions: List.from(json["questions"])
            .map((e) => SurveyQuestionModel.fromJson(e))
            .toList(),
        result: json['result'],
      );
    }
    return null;
  }
}
