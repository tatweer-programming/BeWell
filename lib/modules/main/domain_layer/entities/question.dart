import 'package:equatable/equatable.dart';

class Question extends Equatable {
final  String question ;
final  List<int> trueAnswer ;
 final String ? explanation ;
final List <String> answers ;

const Question({required this.question ,
  required this.trueAnswer , this.explanation , required this.answers ,});
  @override
  List<Object?> get props => [
    question,
    answers ,
    trueAnswer ,
    explanation,
  ];
}
