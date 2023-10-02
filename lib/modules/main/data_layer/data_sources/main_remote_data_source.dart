import 'package:BeWell/modules/main/data_layer/models/daily_reminder_model.dart';
import 'package:BeWell/modules/main/data_layer/models/done_section_model.dart';
import 'package:BeWell/modules/main/data_layer/models/quiz_model.dart';
import 'package:BeWell/modules/main/data_layer/models/statistics_model.dart';
import 'package:BeWell/modules/main/domain_layer/entities/done_section.dart';
import 'package:BeWell/modules/main/domain_layer/entities/section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:BeWell/modules/main/data_layer/models/course_models.dart';
import '../../../../core/utils/constance_manager.dart';
import '../../domain_layer/entities/course.dart';
import '../../domain_layer/entities/daily_reminder.dart';

abstract class BaseMainRemoteDataSource {
  Future<Either<FirebaseException, List<Course>>> getCourses();
  Future<Either<FirebaseException, Unit>> statistics({
    required Section section,
  });
  Future<Either<FirebaseException, DoneSection>> getProgress();
  Future<Either<FirebaseException, List<DailyReminder>>> getDailyReminder();
  Future<Either<FirebaseException, void>> doneSection({
    required String courseName,
    required Section section,
    required int progress,
    required int done,
  });
}

class MainRemoteDataSource extends BaseMainRemoteDataSource {
  @override
  Future<Either<FirebaseException, List<Course>>> getCourses() async {
    try {
      List<Course> courseModel = [];
      await FirebaseFirestore.instance
          .collection("courses")
          .get()
          .then((value) {
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
  Future<Either<FirebaseException, List<DailyReminder>>>
      getDailyReminder() async {
    try {
      List<DailyReminder> dailyReminder = [];
      await FirebaseFirestore.instance
          .collection("dailyReminder")
          .doc("dailyReminder")
          .get()
          .then((value) {
        dailyReminder = List.from(value.data()!['dailyReminder'])
            .map((e) => DailyReminderModel.fromJson(e))
            .toList();
      });
      return Right(dailyReminder);
    } on FirebaseException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseException, Unit>> doneSection({
    required String courseName,
    required Section section,
    required int progress,
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
        });
      });
      return const Right(unit);
    } on FirebaseException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseException, Unit>> statistics({
    required Section section,
  }) async {
    try {
      var statistics =
          FirebaseFirestore.instance.collection("statistics").doc("statistics");

      var statisticsGet = await statistics.get();
      StatisticsModel statisticsModel = StatisticsModel(
              quiz: section.quiz!, sectionName: section.sectionName);
      if (statisticsGet.exists) {
        statisticsGet.data()!.forEach((key, value) {
          QuizModel? quizModel = QuizModel.fromJson(value);
          // check if quiz is exists
          if (section.quiz != null &&
              key == section.sectionName) {
            for (int i = 0; i < section.quiz!.questions.length; i++) {
              // check if student is tested
              if (quizModel!.questions[i].studentsGrades!
                  .containsKey(ConstantsManager.studentName)) {
                // if student is tested , i will update it
                quizModel.questions[i]
                        .studentsGrades![ConstantsManager.studentName!] =
                    section.quiz!.questions[i]
                        .studentsGrades![ConstantsManager.studentName!];
              } else {
                // else , i will add it
                quizModel.questions[i].studentsGrades!.addAll({
                  ConstantsManager.studentName!: section.quiz!.questions[i]
                      .studentsGrades![ConstantsManager.studentName!]
                });
              }
              statisticsModel.quiz = quizModel;
            }
          }
        });
        FirebaseFirestore.instance.runTransaction((transaction) async {
          section.quiz != null
              ? transaction.update(statistics, statisticsModel.toJson())
              : null;
        });
      }
      // else , i will add a new quiz
      else {
        FirebaseFirestore.instance.runTransaction((transaction) async {
          section.quiz != null
              ? transaction.set(statistics, statisticsModel.toJson())
              : null;
        });
      }
      return const Right(unit);
    } on FirebaseException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<FirebaseException, DoneSection>> getProgress() async {
    try {
      var document = FirebaseFirestore.instance
          .collection("progress")
          .doc(ConstantsManager.userId);
      var progress = await document.get();
      DoneSectionModel doneSectionModel = DoneSectionModel(
          studentName: ConstantsManager.studentName!,
          done: const {},
          lastUsing: DateTime.now().toString(),
          progress: const {});
      if (!progress.exists) {
        document.set(doneSectionModel.toJson());
      } else {
        doneSectionModel = DoneSectionModel.fromJson(progress.data()!);
      }
      return Right(doneSectionModel);
    } on FirebaseException catch (error) {
      return Left(error);
    }
  }
}
