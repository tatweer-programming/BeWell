import 'package:BeWell/modules/main/domain_layer/entities/done_section.dart';
import 'package:dartz/dartz.dart';
import '../repositories/base_main_repository.dart';

class GetProgressUseCase {
  final BaseMainRepository baseMainRepository;
  GetProgressUseCase(this.baseMainRepository);
  Future<Either<Exception, DoneSection>> get() {
    return baseMainRepository.getProgress();
  }
}
