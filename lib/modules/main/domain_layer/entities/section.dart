import 'package:BeWell/modules/main/data_layer/models/quiz_model.dart';
import 'package:equatable/equatable.dart';

//ignore: must_be_immutable
class Section extends Equatable{
  String? image;
  String? text;
  List<String>? videosIds;
  QuizModel? quiz;
  Section({
    this.image,
    this.text,
    this.quiz,
    this.videosIds,
  });
  @override
  List<Object?> get props => [text,image,videosIds];
}