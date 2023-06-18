import 'package:BeWell/modules/main/data_layer/models/quiz_model.dart';
import 'package:BeWell/modules/main/domain_layer/entities/survey.dart';
import 'package:equatable/equatable.dart';

//ignore: must_be_immutable
class Section extends Equatable {
  final String sectionName;
  String? image;
  String? text;
  List<String>? videosIds;
  QuizModel? quiz;
  Survey? survey;
  Section({
    this.image,
    required this.sectionName,
    this.text,
    this.quiz,
    this.videosIds,
    this.survey,
  });
  @override
  List<Object?> get props => [text,sectionName, image, videosIds, survey];
}
