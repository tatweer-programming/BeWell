import 'package:BeWell/modules/main/domain_layer/entities/survey_question.dart';

class Survey {
 final List <SurveyQuestion> questions;
 final String result ;

   Survey ({required this.questions , required this.result ,});
}

