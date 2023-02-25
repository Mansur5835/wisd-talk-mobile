import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import '../../data/local_sources/local_storage.dart';
import '../../main.dart';
import '../../presentation/styles/app_colors.dart';

class NotificationServices {
  static final Logger logger = Logger();

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> init() async {
    await AwesomeNotifications().initialize(
      'resource://drawable/mebel',
      [
        NotificationChannel(
            channelShowBadge: true,
            playSound: true,
            channelGroupKey: 'basic_channel',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: AppColors.primaryColor,
            ledColor: Colors.white,
            enableLights: true,
            enableVibration: true,
            importance: NotificationImportance.Max),
      ],
      debug: true,
    );

    AwesomeNotifications().decrementGlobalBadgeCounter().then((value) {
      print(int);
    });

    bool userAllowed = await AwesomeNotifications().isNotificationAllowed();
    logger
        .d("userPermissionToSendNotifications  -----" + userAllowed.toString());

    if (userAllowed) {
      bool userPermissionToSendNotifications =
          await AwesomeNotifications().requestPermissionToSendNotifications();

      if (kDebugMode) {
        logger.d("userPermissionToSendNotifications  -----" +
            userPermissionToSendNotifications.toString());
      }
    }

    await _firebaseMessaging.requestPermission(
      criticalAlert: true,
      carPlay: true,
      alert: true,
      announcement: true,
      badge: true,
      provisional: true,
    );

    AwesomeNotifications().setListeners(
        onActionReceivedMethod: (ReceivedAction event) async {
      _openEntity(event.payload);
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen(
      firebaseMessagingBackgroundHandler,
      onError: (error) {
        logger.e("Error==>" + error);
      },
    );
  }

  Future<String?> setToken() async {
    String? token;
    final LocalStorage _localStorage = LocalStorage();

    try {
      token = await _firebaseMessaging.getToken();
    } catch (e) {
      return null;
    }

    if (kDebugMode) {
      print('\n\n\n\n\n\n\n\n\n\n\n');
      logger.i("Token====>" + token.toString());
    }

    if (token == null) {
      return null;
    }

    if (_localStorage.readData(BoxKeys.DEVISE_TOKEN) != null) {
      return _localStorage.readData(BoxKeys.DEVISE_TOKEN);
    }

    _localStorage.writeData(BoxKeys.DEVISE_TOKEN, token);

    return token;
  }

  static Future<void> _openEntity(Map<String, String?>? json) async {
    _haveContext().then((haveContext) {
      if (json == null) {
        return;
      }

      print(json);
    });
  }

  static Future<bool> _haveContext() async {
    await Future.doWhile(() async {
      return navigatorKey.currentContext == null;
    });

    return true;
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    logger.e("Error==>" + "asdasd");

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: Random().nextInt(3453345),
      channelKey: 'basic_channel',
      title: message.data["title"] ?? "",
      body: message.data["body"] ?? "",
      bigPicture: message.data["bigPicture"],
      payload: {
        "entity_id": message.data["entity_id"],
        "entity_type": message.data["entity_type"]
      },
      largeIcon:
          "https://thumbs.dreamstime.com/z/beautiful-rain-forest-ang-ka-nature-trail-doi-inthanon-national-park-thailand-36703721.jpg",
      notificationLayout: NotificationLayout.BigPicture,
    ));
  }
}
