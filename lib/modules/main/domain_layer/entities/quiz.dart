import 'package:BeWell/modules/main/domain_layer/entities/question.dart';
import 'package:equatable/equatable.dart';

//ignore: must_be_immutable
class Quiz extends Equatable {
  List<Question> questions;
  Quiz({
    required this.questions,
  });
  @override
  List<Object?> get props => [questions];
}
