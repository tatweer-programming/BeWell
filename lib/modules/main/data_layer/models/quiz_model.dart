import 'package:BeWell/modules/main/data_layer/models/question_model.dart';
import 'package:BeWell/modules/main/domain_layer/entities/quiz.dart';

class QuizModel extends Quiz {
  QuizModel({required super.questions, required super.totalMarks});

  factory QuizModel.fromJson(Map<String, dynamic> json) =>
      QuizModel(
         totalMarks: json['totalMarks'],
        questions: _getQuestions(json)
      );

  // get questions from json
  static List<QuestionModel> _getQuestions (Map<String, dynamic> json) {
   List<QuestionModel> questions = [];
   List<Map<String , dynamic>> questionsData = json['questions'] as List <Map<String , dynamic>>;
   for (var element in questionsData) {
     questions.add(QuestionModel.fromJson(element));
   }
   return questions ;
 }
}