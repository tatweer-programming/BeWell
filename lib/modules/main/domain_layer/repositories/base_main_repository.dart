import 'package:BeWell/modules/main/domain_layer/entities/section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../entities/course.dart';
import '../entities/daily_reminder.dart';
import '../entities/done_section.dart';

abstract class BaseMainRepository {
  Future<Either<Exception, List<Course>>> getCourses();
  Future<Either<FirebaseException, void>> doneSection({
    required String courseName,
    required Section section,
    required int progress,
    required int done,
  });
  Future<Either<FirebaseException, DoneSection>> getProgress();
  Future<Either<FirebaseException, Unit>> statistics({
    required Section section,
  });
  Future<Either<FirebaseException, List<DailyReminder>>> getDailyReminder();
}
