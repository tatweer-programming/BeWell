import 'dart:async';
import 'package:BeWell/core/utils/constance_manager.dart';
import 'package:BeWell/modules/authenticaion/presentation_layer/screens/login.dart';
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
import 'modules/main/presentation_layer/screens/courses_screen.dart';
import 'modules/main/presentation_layer/screens/splash_screen.dart';

Future<void> main() async {
  LocalNotification notification = LocalNotification();
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  ServiceLocator().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await notification.initializeLocalNotifications();
  await AwesomeNotifications().requestPermissionToSendNotifications();

  Widget? widget;
  ConstantsManager.userId = await CacheHelper.getData(key: 'uid');
  ConstantsManager.studentName = await CacheHelper.getData(key: 'studentName');

  if (ConstantsManager.userId == null || ConstantsManager.userId == '') {
    widget = const LoginScreen();
  } else {
    String? lastDailyReminder = await CacheHelper.getData(key: "dailyReminder");
    if (lastDailyReminder != null) {
      DateTime lastDate = DateTime.parse(lastDailyReminder);
      DateTime currentDate = DateTime.now();
      if(lastDate.day != currentDate.day ||
          lastDate.month != currentDate.month ||
          lastDate.year != currentDate.year){
        ConstantsManager.lastDailyReminder = true;
      }
    }
    else{
      ConstantsManager.lastDailyReminder = true;
    }
    widget = const CoursesScreen();
  }

  if (ConstantsManager.userId != null &&
      ConstantsManager.userId != '') {
    await notification.createWaterReminder();
  }

  runApp(MyApp(startWidget: widget));

  await notification.startListeningNotificationEvents();
}

//ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Widget? startWidget;
  MyApp({super.key, this.startWidget});
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<MainBloc>(
            create: (BuildContext context) => sl()
              ..add(GetDailyReminderEvent())
              ..add(GetCoursesEvent())
              ..add(GetProgressEvent())
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
              Locale('en', 'US'), // English, no country code
            ],
            locale: const Locale('ar',"en"),
            home: SplashScreen(nextScreen: startWidget!),
            ),
      );
    });
  }
}