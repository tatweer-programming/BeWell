import 'package:BeWell/modules/main/domain_layer/entities/survey_question.dart';

class Survey {
 final List <SurveyQuestion> questions;
 final String result ;
  int userResult ;
   Survey ({required this.questions , required this.result , this.userResult = 0});
}

