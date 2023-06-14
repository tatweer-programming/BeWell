import 'package:BeWell/core/local/shared_prefrences.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:permission_handler/permission_handler.dart';


class LocalNotification {

  // Initialization
  Future<void> initializeLocalNotifications() async {

    await AwesomeNotifications().initialize(
      null,//'asset://assets/images/water-cup.png',
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
    await requestNotificationPermissions();
    bool? callWaterReminder = await CacheHelper.getData(key: 'callWaterReminder');
    print(callWaterReminder);
    if (callWaterReminder == null || callWaterReminder){
      await createWaterReminder();
    }
  }


  Future<void> startListeningNotificationEvents() async {
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
    );
  }


  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {

    final payload = receivedAction.payload ?? {};
    if (payload["drank"] == "true") {
      int currentValue =  await CacheHelper.getData(key: 'waterCups') ;
      print("currentValue           $currentValue");
      if (currentValue == 7){
        await CacheHelper.saveData(key: 'waterCups', value: 0);
        await _congratsNotification();
      }
      else {
        await CacheHelper.saveData(key: 'waterCups', value: currentValue+1);
      }
    }
  }



  // REQUESTING NOTIFICATION PERMISSIONS
  Future<bool> requestNotificationPermissions() async {
    await AwesomeNotifications().requestPermissionToSendNotifications(
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
      await AwesomeNotifications().requestPermissionToSendNotifications();

      if (result == true) {
        return true;
      } else {
        return false;
      }
    }
  }

  // Create Water Reminder
  Future<void> createWaterReminder() async {
    await CacheHelper.saveData(key: 'callWaterReminder', value: false);
    await CacheHelper.saveData(key: 'waterCups', value: 0);
    DateTime sevenAM = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 7, 0);
    for (int day = DateTime.monday; day <= DateTime.sunday; day++) {
      for (int i = 1; i <= 8; i++) {
        final DateTime notificationTime = sevenAM
            .add(Duration(days: day - DateTime
            .now()
            .weekday))
            .add(Duration(minutes: 112 * i,seconds: 30 * i)); // convert minutes to hours
        await AwesomeNotifications().createNotification(
          actionButtons: [
            NotificationActionButton(
              key: 'confirm',
              label: 'شربت كوبًا',
              autoDismissible: true,
            ),
          ],
          content: NotificationContent(
            id: i + (day * 10),
            payload: {
              "drank": "true",
            },
            channelKey: 'water-reminder',
            title: 'تذكير بشرب الماء',
            body: 'لا تنس شرب كوب من الماء',
            displayOnBackground: true,
            displayOnForeground: true,
            autoDismissible: true,
          ),
          schedule: NotificationCalendar(
            weekday: day,
            hour: notificationTime.hour,
            minute: notificationTime.minute,
            second: notificationTime.second,
            millisecond: 0,
            allowWhileIdle: true,
          ),
        );
      }
    }
  }


  static Future<void> _congratsNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 39,
        channelKey: 'water-reminder',
        title: 'تهانينا',
        body: 'لقد شربت كمية كافية من الماء اليوم',
        displayOnBackground: true,
        displayOnForeground: true,
        autoDismissible: true,
      ),
    );
  }

  /// Use this method to detect every time that a new notification is displayed
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    print("receivedNotification.id  ${receivedNotification.id}");
    if(receivedNotification.id == 39){
      await CacheHelper.saveData(key: 'waterCups', value: 0);
    }
  }
}