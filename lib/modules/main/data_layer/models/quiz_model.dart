import 'package:BeWell/modules/main/data_layer/models/question_model.dart';
import 'package:BeWell/modules/main/domain_layer/entities/quiz.dart';

//ignore: must_be_immutable
class QuizModel extends Quiz {
  QuizModel({required super.questions});

  static QuizModel? fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return QuizModel(
        questions: List.from(json["questions"])
            .map((e) => QuestionModel.fromJson(e))
            .toList(),
      );
    }
    return null;
  }

  Map <String , dynamic> toJson(){
    return {
      'questions' : questions.map((e) => e.toJson()).toList(),
    };
  }
}
