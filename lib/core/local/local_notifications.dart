import 'package:BeWell/core/local/shared_prefrences.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';
import '../utils/color_manager.dart';

class LocalNotification {
  // Initialization
  Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'alerts',
          channelName: 'Alerts',
          channelDescription: 'Notification tests as alerts',
          playSound: true,
          onlyAlertOnce: true,
          groupAlertBehavior: GroupAlertBehavior.Children,
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Private,
          defaultColor: ColorManager.primary,
          ledColor: ColorManager.primary,
        ),
        NotificationChannel(
          channelKey: 'water-reminder',
          channelName: 'water-reminder',
          channelDescription: 'Notification tests as water reminders',
          playSound: true,
          onlyAlertOnce: true,
          groupAlertBehavior: GroupAlertBehavior.Children,
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Private,
          defaultColor: ColorManager.primary,
          ledColor: ColorManager.primary,
        ),
      ],
      debug: true,
    );
  }

  Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications().setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  @pragma('vm:entry-point')
  Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    if (receivedAction.payload?["drank"] == "true") {
      int currentValue = await CacheHelper.getData(key: 'waterCups');
      print(" currentValue  $currentValue");
      if (currentValue == 7) {
        await CacheHelper.saveData(key: 'waterCups', value: 0);
        await _congratsNotification();
      } else {
        await CacheHelper.saveData(key: 'waterCups', value: currentValue + 1);
      }
    }
    if (receivedAction.id == 59) {
      await CacheHelper.saveData(key: 'waterCups', value: 0);
    }
  }

  Future<void> scheduleNewNotification() async {
    await cancelNotifications();
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            displayOnForeground: true,
            id: 1,
            channelKey: 'alerts',
            title: "تذكير الاستخدام",
            body: "لم تستخدم التطبيق منذ فترة. نحن نفتقدك",
            displayOnBackground: true,
            backgroundColor: ColorManager.primary,
            notificationLayout: NotificationLayout.Default,
            payload: {'notificationId': '1234567890'}),
        schedule: NotificationCalendar.fromDate(
            date: DateTime.now().add(const Duration(
              days: 2,
            ))));
  }

  static Future<void> cancelNotifications() async {
    await AwesomeNotifications().cancelSchedulesByChannelKey("alerts");
  }

  Future<void> createWaterReminder() async {
    bool isAllowed = await AwesomeNotifications().requestPermissionToSendNotifications();
    if (isAllowed) {
      await scheduleNewNotification();
      await CacheHelper.saveData(key: 'callWaterReminder', value: false);
      await CacheHelper.saveData(key: 'waterCups', value: 0);
      DateTime sevenAM = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 7, 0, 0, 0, 0);
      DateTime notificationTime = sevenAM;
      for (int day = DateTime.monday; day <= DateTime.sunday; day++) {
        for (int i = 1; i <= 8; i++) {
          notificationTime = sevenAM.add(Duration(days: day)).add(Duration(seconds: 6720 * (i - 1)));
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
              millisecond: notificationTime.millisecond,
              repeats: true,
              allowWhileIdle: true,
            ),
          );
        }
      }
    } else {
      // Do nothing if permission is not granted
    }
  }

  Future<void> _congratsNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 59,
        payload: {
          "drank": "false",
        },
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
