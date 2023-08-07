import 'package:BeWell/modules/main/domain_layer/entities/question.dart';
//ignore: must_be_immutable
class QuestionModel extends Question {
    QuestionModel({
    required super.question,
    required super.trueAnswer,
    required super.answers,
       super.studentsGrades,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'],
      studentsGrades: json['studentsGrades'],
      trueAnswer: List<int>.from(json['trueAnswer']).map((e) => e).toList(),
      answers: List<String>.from(json['answers']).map((e) => e).toList(),
    );
  }
    Map <String, dynamic> toJson() {
      return {
        'question': question,
        'trueAnswer': trueAnswer,
        'answers': answers,
        'studentsGrades': studentsGrades,
      };
    }
}
