import 'package:BeWell/modules/main/presentation_layer/components/test.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BeWell/core/local/local_notifications.dart';
import 'package:BeWell/core/services/dep_injection.dart';
import 'package:sizer/sizer.dart';
import 'core/local/shared_prefrences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/utils/theme_manager.dart';
import 'firebase_options.dart';
import 'modules/authenticaion/presentation_layer/bloc/auth_bloc.dart';
import 'modules/main/presentation_layer/bloc/main_bloc.dart';
import 'modules/main/presentation_layer/screens/course_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
  bool callWaterReminder = await CacheHelper.getData(key: 'callWaterReminder');
 if (callWaterReminder){
  await LocalNotification.createWaterReminder() ;
 }
  await CacheHelper.init();
  await LocalNotification.initializeLocalNotifications();
  await AwesomeNotifications().requestPermissionToSendNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<MainBloc>(
            create: (BuildContext context) => sl()..add(GetCoursesEvent())..add(GetProgressEvent()),
          ),
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => sl(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BeWell',
          theme: getAppTheme(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar', 'AE'), // English, no country code
          ],
          home: const TestQuizScreen(),
        ),
      );
    });
  }
}