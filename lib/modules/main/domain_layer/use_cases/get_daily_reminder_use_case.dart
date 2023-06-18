import 'package:BeWell/modules/main/domain_layer/entities/daily_reminder.dart';
import 'package:dartz/dartz.dart';
import '../repositories/base_main_repository.dart';

class GetDailyReminderUseCase {
  final BaseMainRepository baseMainRepository;
  GetDailyReminderUseCase(this.baseMainRepository);
  Future<Either<Exception, List<DailyReminder>>> get() {
    return baseMainRepository.getDailyReminder();
  }
}