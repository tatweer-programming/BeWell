import 'package:BeWell/modules/main/data_layer/models/course_models.dart';
import 'package:BeWell/modules/main/data_layer/models/lesson_model.dart';
import 'package:BeWell/modules/main/data_layer/models/question_model.dart';
import 'package:BeWell/modules/main/data_layer/models/quiz_model.dart';
import 'package:BeWell/modules/main/data_layer/models/section_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> saveData(
      {required String key, required dynamic value}) async {
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }
    return await sharedPreferences.setDouble(key, value);
  }

  static Future<dynamic> getData({required String key}) async {
    return sharedPreferences.get(key);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }
}

CourseModel courseModel = CourseModel(
    courseName: 'Mental health  الصحة العقلية',
    courseImage: '',
    lessons: [
      LessonModel(lessonName: 'فهم القلقUnderstanding anxiety', sections: [
        SectionsModel(
          sectionName: 'القلق',
          videosIds: [
            '8pffS19siRE',
          ],
          quiz: QuizModel(questions: [
            QuestionModel(
                question: '1-	تتحول مشاعر القلق إلى حالة مرضية إذا استمرت نحو:',
                trueAnswer: [
                  1,
                ],
                answers: [
                  'أ‌.	يومين',
                  'ب‌.	بضعة أسابيع أو أشهر',
                  'ت‌.	سنة'
                ]),
            QuestionModel(
                question:
                    '2-	صح أم خطأ : يعد تجنب المواقف الإجتماعية نوع من أنواع القلق. ',
                trueAnswer: [0],
                answers: ['صح', 'خطأ']),
          ]),
        )
      ]),
      LessonModel(sections: [
        SectionsModel(
          sectionName: ' قلق الامتحان',
          videosIds: ['ocx3pHfreyc'],
        ),
      ], lessonName: 'التعامل مع قلق الاختبارات Dealing with exam anxiety'),
      LessonModel(sections: [
        SectionsModel(
            sectionName: 'كيف تتعامل مع الرهاب الاجتماعي؟ ',
            image:
                'https://firebasestorage.googleapis.com/v0/b/bewell-a2eba.appspot.com/o/imagesOfSections%2FPicture7.png?alt=media&token=69e6d445-4335-4951-8ca2-ac2bda37d54c',
            videosIds: [
              'LdSpoAFa8EY',
            ]),
      ], lessonName: 'Social contact'),
      LessonModel(sections: [
        SectionsModel(
            sectionName: 'كيف تتخلص من إدمان مواقع التواصل الاجتماعي؟ ',
            videosIds: const [
              'v3p_KnYaGLk',
              'ZEKZbg70SIQ',
              'coA0PxypawQ',
            ],
            image:
                'https://firebasestorage.googleapis.com/v0/b/bewell-a2eba.appspot.com/o/imagesOfSections%2FPicture8.png?alt=media&token=e4fd3aea-4474-494e-8efa-e22a0e4806f4')
      ], lessonName: 'التعامل مع الهاتف المحمول Screen time'),
      LessonModel(
        sections: [
          SectionsModel(
              sectionName: 'مهارات التواصل بين الأباء والابناء',
              image:
                  'https://firebasestorage.googleapis.com/v0/b/bewell-a2eba.appspot.com/o/imagesOfSections%2FPicture9.png?alt=media&token=e06a3134-746a-4bcb-a1a2-d9b0772fc1bf',
              quiz: QuizModel(
                questions: [
                  QuestionModel(
                      question: 'question',
                      trueAnswer: [0],
                      answers: ['صح', 'خطأ']),
                  QuestionModel(
                      question:
                          'تعد مهارة السلوك غير اللفظي من أهم مهارات التواصل بين الابناء والاباء ',
                      trueAnswer: [0],
                      answers: ['صح', 'خطأ'])
                ],
              ),
              videosIds: ['72aQVMX9zv4'])
        ],
        lessonName: 'العلاقة مع الوالدين',
      ),
    ]);
