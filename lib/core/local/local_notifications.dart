import 'package:BeWell/core/local/shared_prefrences.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalNotification {
  static ReceivedAction? initialAction;
 static AwesomeNotifications awesomeNotifications = AwesomeNotifications();


  // Initialization
  static Future<void> initializeLocalNotifications() async {

    await awesomeNotifications.initialize(
      'asset://assets/images/water-cup.png',
      [
        NotificationChannel(
          channelKey: 'alerts',
          channelName: 'Alerts',
          channelDescription: 'Notification tests as alerts',
        ),
        NotificationChannel(
          channelKey: 'water-reminder',
          channelName: 'water-reminder',
          channelDescription: 'Notification tests as alerts',
        ),
      ],
      debug: true,
    );

  }

  // REQUESTING NOTIFICATION PERMISSIONS
  static Future<bool> requestNotificationPermissions() async {
    await awesomeNotifications.requestPermissionToSendNotifications(
      channelKey: 'alerts',
      permissions: [
        NotificationPermission.Light,
        NotificationPermission.Alert,
        NotificationPermission.Sound,
        NotificationPermission.Vibration,
      ],
    );
    if (await Permission.scheduleExactAlarm.isGranted &&
        await Permission.notification.isGranted) {
      return true;
    } else {
      var result =
      await awesomeNotifications.requestPermissionToSendNotifications();

      if (result == true) {
        return true;
      } else {
        return false;
      }
    }
  }

  // NOTIFICATION CREATION METHODS
  static Future<void> createWaterReminder() async {
   await CacheHelper.saveData(key: 'callWaterReminder', value: false);
    await CacheHelper.saveData(key: 'waterCups', value: 0);
    DateTime now = DateTime.now();
    for (int i = 0; i < 8; i++) {
      await awesomeNotifications.createNotification(
        actionButtons: [
          NotificationActionButton(
            key: 'confirm',
            label: 'شربت كوبًا',
            autoDismissible: true,
            buttonType: ActionButtonType.Default,
          ),
          NotificationActionButton(
            key: 'ignore',
            label: 'تجاهل',
            autoDismissible: true,
            buttonType: ActionButtonType.Default,
          ),
        ],
        content: NotificationContent(
          id: i + 1,
          channelKey: 'water-reminder',
          title: 'تذكير بشرب الماء',
          body: 'لا تنس شرب كوب من الماء',
          displayOnBackground: true,
          displayOnForeground: true,
          autoDismissible: true,
        ),
        schedule: NotificationCalendar(
          weekday: DateTime.monday |
          DateTime.tuesday |
          DateTime.wednesday |
          DateTime.thursday |
          DateTime.friday |
          DateTime.saturday |
          DateTime.sunday,
          hour: now.hour,
          minute: now.minute + (i * 90),
          second: now.second,
          millisecond: now.millisecond,
          repeats: true,
        ),
      );
    }
    awesomeNotifications.actionStream.listen((ReceivedAction receivedAction) async {
      if (receivedAction != null ) {
        if (receivedAction.buttonKeyPressed == 'confirm') {
          int currentValue =  await CacheHelper.getData(key: 'waterCups') ;
          if (currentValue == 8 ){
           await CacheHelper.saveData(key: 'waterCups', value: 0);
             await _congratsNotification();
          }
          else {
           await CacheHelper.saveData(key: 'waterCups', value: currentValue+1);
          }

        }
        else if (receivedAction.id == 7){
          await CacheHelper.saveData(key: 'waterCups', value: 0);
        }
      }
    });
  }
  static  Future<void> _congratsNotification() async{
    await awesomeNotifications.createNotification(
      content: NotificationContent(
        id: 9,
        channelKey: 'water-reminder',
        title: 'تهانينا',
        body: 'لقد شربت كمية كافية من الماء اليوم',
        displayOnBackground: true,
        displayOnForeground: true,
        autoDismissible: true,
      ),
    );
  }


}