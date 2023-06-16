import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../entities/course.dart';
import '../entities/done_section.dart';

abstract class BaseMainRepository {
  Future<Either<Exception, List<Course>>> getCourses();
  Future<Either<FirebaseException, void>> doneSection({
    required String courseName,
    required double progress,
    required int done,
  });
  Future<Either<FirebaseException, DoneSection>> getProgress();
}
