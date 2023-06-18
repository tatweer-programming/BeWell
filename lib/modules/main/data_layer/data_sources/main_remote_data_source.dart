import 'package:BeWell/modules/main/data_layer/models/daily_reminder_model.dart';
import 'package:BeWell/modules/main/data_layer/models/done_section_model.dart';
import 'package:BeWell/modules/main/domain_layer/entities/done_section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:BeWell/modules/main/data_layer/models/course_models.dart';
import '../../../../core/utils/constance_manager.dart';
import '../../domain_layer/entities/course.dart';
import '../../domain_layer/entities/daily_reminder.dart';

abstract class BaseMainRemoteDataSource {
  Future<Either<FirebaseException, List<Course>>> getCourses();
  Future<Either<FirebaseException, DoneSection>> getProgress();
  Future<Either<FirebaseException, List<DailyReminder>>> getDailyReminder();
  Future<Either<FirebaseException, void>> doneSection({
    required String courseName,
    required double progress,
    required int done,
  });
}

class MainRemoteDataSource extends BaseMainRemoteDataSource {
  @override
  Future<Either<FirebaseException, List<Course>>> getCourses() async {
    try {
      List<Course> courseModel = [];
      await FirebaseFirestore.instance.collection("courses").get().then((value) {
        for (var element in value.docs) {
          courseModel.add(CourseModel.fromJson(element.data()));
        }
      });
      return Right(courseModel);
    } on FirebaseException catch (error) {
      return Left(error);
    }
  }
  @override
  Future<Either<FirebaseException, List<DailyReminder>>> getDailyReminder() async {
    try {
      List<DailyReminder> dailyReminder = [];
      await FirebaseFirestore.instance.collection("dailyReminder").doc("dailyReminder").get()
          .then((value) {
        dailyReminder = List.from(value.data()!['dailyReminder']).map((e)
        => DailyReminderModel.fromJson(e)).toList();
      });
      return Right(dailyReminder);
    } on FirebaseException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseException, Unit>> doneSection({
    required String courseName,
    required double progress,
    required int done,
  }) async {
    try {
      var document = FirebaseFirestore.instance
          .collection("progress")
          .doc(ConstantsManager.userId);
      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.update(document, {
          "done.$courseName": done,
          "progress.$courseName": progress,
          "lastUsing": DateTime.now().toString(),
          "studentName":ConstantsManager.studentName
        });
      });
      return const Right(unit);
    } on FirebaseException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseException, DoneSection>> getProgress() async {
    try {
      DoneSectionModel? doneSectionModel;
      await FirebaseFirestore.instance
          .collection("progress")
          .doc(ConstantsManager.userId)
          .get()
          .then((value) {
            print("getProgress");
        doneSectionModel = DoneSectionModel.fromJson(value.data()!);
      });
      return Right(doneSectionModel!);
    } on FirebaseException catch (error) {
      return Left(error);
    }
  }
}
