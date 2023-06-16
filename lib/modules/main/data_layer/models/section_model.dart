import 'package:BeWell/modules/main/data_layer/models/quiz_model.dart';
import 'package:BeWell/modules/main/data_layer/models/survey_model.dart';
import '../../domain_layer/entities/section.dart';

//ignore: must_be_immutable
class SectionsModel extends Section{
  SectionsModel({
    super.videosIds,
    super.image,
    super.text,
    super.quiz,
    super.survey,
  });
  factory SectionsModel.fromJson(Map<String, dynamic> json) =>
      SectionsModel(
          quiz: QuizModel.fromJson(json['quiz']),
          survey: SurveyModel.fromJson(json['survey']),
          image: json['image'],
          text: json['text'],
          videosIds: List<String>.from(json['videosIds']).map((videoId) => videoId).toList()
      );
}