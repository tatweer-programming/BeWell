import 'package:BeWell/modules/main/domain_layer/entities/done_section.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../domain_layer/entities/course.dart';
import '../../domain_layer/entities/daily_reminder.dart';
import '../../domain_layer/repositories/base_main_repository.dart';
import '../data_sources/main_remote_data_source.dart';

class MainRepository extends BaseMainRepository {
  BaseMainRemoteDataSource baseMainRemoteDataSource;
  MainRepository(this.baseMainRemoteDataSource);
  @override
  Future<Either<FirebaseException, List<Course>>> getCourses() async {
    return await baseMainRemoteDataSource.getCourses();
  }
  @override
  Future<Either<FirebaseException, List<DailyReminder>>> getDailyReminder() async {
    return await baseMainRemoteDataSource.getDailyReminder();
  }

  @override
  Future<Either<FirebaseException, void>> doneSection({
    required String courseName,
    required double progress,
    required int done,
  }) async {
    return await baseMainRemoteDataSource.doneSection(
        courseName: courseName, done: done, progress: progress);
  }

  @override
  Future<Either<FirebaseException, DoneSection>> getProgress() async {
    return await baseMainRemoteDataSource.getProgress();
  }
}
