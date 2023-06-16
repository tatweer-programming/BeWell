import 'package:BeWell/modules/main/data_layer/models/quiz_model.dart';
import 'package:BeWell/modules/main/domain_layer/entities/quiz.dart';
import 'package:BeWell/modules/main/domain_layer/entities/survey.dart';
import 'package:equatable/equatable.dart';

import '../../data_layer/models/survey_model.dart';

//ignore: must_be_immutable
class Section extends Equatable{
  String? image;
  String? text;
  List<String>? videosIds;
  QuizModel? quiz;
  Survey ? survey ;
  Section({
    this.image,
    this.text,
    this.quiz,
    this.videosIds,
    this.survey ,
  });
  @override
  List<Object?> get props => [text,image,videosIds, survey] ;
}