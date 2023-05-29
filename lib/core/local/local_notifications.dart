import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils/color_manager.dart';

class LocalNotification {
  static ReceivedAction? initialAction;


  //     Initialization
  static Future<void> initializeLocalNotifications() async {

    await AwesomeNotifications().initialize(
        null, //'resource://drawable/res_app_icon',//
        [
          NotificationChannel(
            channelKey: 'alerts',
            channelName: 'Alerts',
            channelDescription: 'Notification tests as alerts',
            playSound: true,
            onlyAlertOnce: true,
            groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Public,
            defaultColor: ColorManager.primary,
            ledColor: ColorManager.black ,
          )
        ],
        debug: true );


  }

  //    REQUESTING NOTIFICATION PERMISSIONS

  static Future<bool> requestNotificationPermissions() async {

    AwesomeNotifications().requestPermissionToSendNotifications( channelKey: 'alerts', permissions:
    [
      NotificationPermission.Light,
      NotificationPermission.Alert ,
      NotificationPermission.Sound,
      NotificationPermission.Vibration,
    ]);
    if (await Permission.scheduleExactAlarm.isGranted && await Permission.notification.isGranted ) {
      return true;
    } else {
      var result = await AwesomeNotifications().requestPermissionToSendNotifications();

      if (result == true ) {
        return true;
      } else {
        return false;
      }
    }
  }


  //  NOTIFICATION CREATION METHODS


  static Future<void> scheduleNewNotification() async {
    print('2');
    bool isAllowed = await requestNotificationPermissions();
    if (isAllowed){
      print('2');
      print("Allowed");
      await cancelNotifications() ;
      await AwesomeNotifications().createNotification(
          content: NotificationContent(
              displayOnForeground: true,
              id: 1,
              channelKey: 'alerts',
              title: "اشتقنا",
              body:
              "لم تستخدم التطبيق منذ فترة. نحن نفتقدك",
              displayOnBackground: true,
              backgroundColor: ColorManager.primary,
              notificationLayout: NotificationLayout.Default,
              payload: {
                'notificationId': '1234567890'
              }),
          schedule: NotificationCalendar.fromDate(
              date: DateTime.now().add(const Duration(seconds: 1 , ))));
    }
    else {
      print('4');
      DoNothingAction();
    }
  }

  static Future<void> resetBadgeCounter() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  static Future<void> cancelNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }
}

