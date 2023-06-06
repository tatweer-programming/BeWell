import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BeWell/core/local/local_notifications.dart';
import 'package:BeWell/core/services/dep_injection.dart';
import 'package:sizer/sizer.dart';
import 'core/local/shared_prefrences.dart';
import 'core/utils/theme_manager.dart';
import 'firebase_options.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'modules/main/presentation_layer/bloc/main_bloc.dart';
import 'modules/main/presentation_layer/screens/course_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
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
            create: (BuildContext context) => MainBloc(MainInitial())..add(GetCoursesEvent()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: getAppTheme(),
          // localizationsDelegates: const [
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          // ],
          // supportedLocales: const [
          //   Locale('ar', 'AE'), // English, no country code
          // ],
          home: const CourseScreen(),
        ),
      );
    });
  }
}