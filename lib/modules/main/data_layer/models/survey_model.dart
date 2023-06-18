import 'package:BeWell/modules/main/data_layer/models/servey_question_model.dart';
import 'package:BeWell/modules/main/domain_layer/entities/survey.dart';

class SurveyModel extends Survey {
  SurveyModel({
    required super.questions,
    required super.result,
  });

  static SurveyModel? fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      final List<dynamic> questionsJson = json['questions'];
      final List<SurveyQuestionModel> questions = questionsJson
          .map((questionJson) => SurveyQuestionModel.fromJson(questionJson))
          .toList();

      final Map<String, dynamic> resultJson = json['result'];
      final Map<List<int>, String> result = resultJson.map((key, value) {
        final List<int> parsedKey =
        key.split(',').map((str) => int.parse(str)).toList();
        return MapEntry(parsedKey, value);
      });
      return SurveyModel(
        questions: questions,
        result: result
      );
    }
    return null;
  }
}
