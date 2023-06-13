import 'package:BeWell/modules/main/data_layer/models/question_model.dart';
import 'package:BeWell/modules/main/domain_layer/entities/quiz.dart';

import '../../domain_layer/entities/question.dart';

class QuizModel extends Quiz {
  QuizModel({ required super.questions});

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
        questions: List.from(json["questions"])
            .map((e) => QuestionModel.fromJson(e)).toList(),
    );
   // QuizModel quizModel = QuizModel (
   //
   //      questions: _getQuestions(json)
   //  ) ;
   //return quizModel ;
  }

 // get questions from json
 //  static List<Question> _getQuestions (Map<String, dynamic> json) {
 //   List<Question> questions = [];
 //   List<Map<String , dynamic>> questionsData = json['questions'] as List <Map<String , dynamic>>;
 //   for (var element in questionsData) {
 //     questions.add(QuestionModel.fromJson(element));
 //   }
 //   return questions ;
 // }
}