import 'package:BeWell/core/local/shared_prefrences.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:permission_handler/permission_handler.dart';


class LocalNotification {
   ReceivedAction? initialAction;



  // Initialization
   Future<void> initializeLocalNotifications() async {

    await AwesomeNotifications().initialize(
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
    // Get initial notification action is optional
    initialAction = await AwesomeNotifications().getInitialNotificationAction(removeFromActionEvents: false);
  }


   Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }


  @pragma('vm:entry-point')
   Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
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

  // NOTIFICATION CREATION METHODS
   Future<void> createWaterReminder() async {
   await CacheHelper.saveData(key: 'callWaterReminder', value: false);
    await CacheHelper.saveData(key: 'waterCups', value: 0);
    DateTime now = DateTime.now();
    for (int i = 0; i < 8; i++) {
      await AwesomeNotifications().createNotification(
        actionButtons: [
          NotificationActionButton(
            key: 'confirm',
            label: 'شربت كوبًا',
            autoDismissible: true,
          ),
          NotificationActionButton(
            key: 'ignore',
            label: 'تجاهل',
            autoDismissible: true,
            actionType: ActionType.Default,
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
          actionType: ActionType.Default,
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

  }
    Future<void> _congratsNotification() async{
    await AwesomeNotifications().createNotification(
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