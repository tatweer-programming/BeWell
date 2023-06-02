import 'package:BeWell/modules/main/data_layer/models/quiz_model.dart';
import 'package:BeWell/modules/main/domain_layer/entities/quiz.dart';

import '../../domain_layer/entities/section.dart';

//ignore: must_be_immutable
class SectionsModel extends Section{
  SectionsModel({
    super.videoId,
    super.sectionImage,
    super.quiz,
  });
  factory SectionsModel.fromJson(Map<String, dynamic> json) =>
      SectionsModel (
          quiz: QuizModel.fromJson(json['quiz']),
          sectionImage: json['sectionImage'],
          videoId: json['videoId'],);

  Map<String, dynamic> toJson() {

    return
      {
      "quiz": quiz?.toJson(),
      "videoId":videoId,
      "sectionImage":sectionImage,
      };
  }
}