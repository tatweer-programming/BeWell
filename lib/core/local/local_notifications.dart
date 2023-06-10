import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils/color_manager.dart';

class LocalNotification {
  static ReceivedAction? initialAction;

  // Initialization
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
          ledColor: ColorManager.black,
        )
      ],
      debug: true,
    );
  }

  // REQUESTING NOTIFICATION PERMISSIONS
  static Future<bool> requestNotificationPermissions() async {
    AwesomeNotifications().requestPermissionToSendNotifications(
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
  static Future<void> scheduleNewNotification() async {
    bool isAllowed = await requestNotificationPermissions();
    if (isAllowed) {
      print('Notifications allowed');
      await cancelNotifications();
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          displayOnForeground: true,
          id: 11,
          channelKey: 'alerts',
          title: "اشتقنا",
          body: "لم تستخدم التطبيق منذ فترة. نحن نفتقدك",
          displayOnBackground: true,
          backgroundColor: ColorManager.primary,
          notificationLayout: NotificationLayout.Default,
          payload: {'notificationId': '1234567890'},
        ),
        schedule: NotificationCalendar.fromDate(
          date: DateTime.now().add(
            const Duration(
              days: 2,
            ),
          ),
        ),
      );
    } else {
      print('Notifications not allowed');
      DoNothingAction();
    }
  }

  static Future<void> resetBadgeCounter() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  static Future<void> cancelNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }

  static Future<void> scheduleDailyNotifications() async {
    bool isAllowed = await requestNotificationPermissions();
    if (isAllowed) {
      print('Notifications allowed');
      await cancelNotifications();
      DateTime now = DateTime.now();
      for (int i = 0; i < 8; i++) {
        DateTime notificationTime = DateTime(now.year, now.month, now.day, 8 + i, 0, 0);
        await AwesomeNotifications().createNotification(
          actionButtons:  [
            NotificationActionButton(
              key: 'drink',
              label: 'شربت',

              buttonType: ActionButtonType.KeepOnTop,
              enabled: true,
              icon: 'resource://drawable/ic_drink',

            ),
            NotificationActionButton(
              key: 'ignore',
              label: 'تجاهل',
              buttonType: ActionButtonType.DisabledAction,
              enabled: true,
              icon: 'resource://drawable/ic_ignore',
            ),
          ],
          content: NotificationContent(
            id: i + 1,
            channelKey: 'alerts',
            title: 'شرب الماء',
            body: 'هل شربت الماء اليوم؟',
            bigPicture: 'asset://assets/images/drink_water.png',
            notificationLayout: NotificationLayout.BigPicture,
            payload: {
              'notificationId': '1234567890',
              'action': 'drink',
            },

          ),
          schedule: NotificationCalendar(
            weekday: notificationTime.weekday,
            hour: notificationTime.hour,
            minute: notificationTime.minute,
            second: notificationTime.second,
            repeats: true,
          ),
        );
      }

      // Add congratulations notification
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 100,
          channelKey: 'alerts',
          title: 'تهانينا!',
          body: 'لقد تمكنت من شرب الماء الكافي اليوم. استمر!',
          notificationLayout: NotificationLayout.Default,
          payload: {
            'notificationId': '1234567890',
            'action': 'congratulate',
          },
        ),
        schedule: NotificationCalendar(
          weekday: DateTime.daysPerWeek,
          hour: 20,
          minute: 0,
          second: 0,
          repeats: true,
        ),
      );
    } else {
      print('Notifications not allowed');
      DoNothingAction();
    }
  }
}