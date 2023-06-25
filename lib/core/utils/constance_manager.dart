import '../../modules/authenticaion/data_layer/models/user_model.dart';
import '../../modules/main/domain_layer/entities/done_section.dart';

class ConstantsManager {
  static String? userId  ;
  static UserModel? appUser;
  static DoneSection? doneSection;
  static String? studentName;
  static bool lastDailyReminder = false;
  static int? waterCups = 0;
}