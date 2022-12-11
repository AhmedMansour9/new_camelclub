import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:new_camelclub/main.dart';
import 'package:new_camelclub/utill/app_constants.dart';
import 'package:path_provider/path_provider.dart';

class MyNotification {

  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('app_icon');
    var iOSInitialize = new IOSInitializationSettings();
    var initializationsSettings = new InitializationSettings( iOS: iOSInitialize,android: androidInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings, onSelectNotification: (String? payload) async {
      try{
        // if(payload != null && payload.isNotEmpty) {
        //   MyApp.navigatorKey.currentState!.push(
        //       MaterialPageRoute(builder: (context) => OrderDetailsScreen(orderModel: null, orderId: int.parse(payload))));
        // }
      }catch (e) {

      }

      return;
    });



    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: ${message.data}");
      MyNotification.showNotification(message.data, flutterLocalNotificationsPlugin);
    });
    // FirebaseMessaging.onBackgroundMessage((message)  {
    //   print("onMessage: ${message.data}");
    //   MyNotification.showNotification(message.data, flutterLocalNotificationsPlugin);
    // });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageApp: ${message.data}");

    });
  }
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message");
    var androidInitialize = new AndroidInitializationSettings('app_icon');
    var iOSInitialize = new IOSInitializationSettings();
    var initializationsSettings = new InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationsSettings);
    MyNotification.showNotification(message.data, flutterLocalNotificationsPlugin);
  }
  static Future<void> showNotification(Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {
    // if(message['image'] != null && message['image'].isNotEmpty) {
    //   try{
    //     await showBigPictureNotificationHiddenLargeIcon(message, fln);
    //   }catch(e) {
    //     await showBigTextNotification(message, fln);
    //   }
    // }else {
      await showBigTextNotification(message, fln);
    // }
  }

  static Future<void> showTextNotification(Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {
    String _title = message['title'];
    String _body = message['body'];
    String _orderID = message['order_id'];
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', channelDescription: 'your channel description', sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max, priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, _title, _body, platformChannelSpecifics, payload: _orderID);
  }


  static Future<void> showBigTextNotification(Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {


    var android = const AndroidNotificationDetails('channel_id', 'CHANNEL_NAME');
    var ios = const IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: ios);


    String _title = message['title'];
    String _body = message['body'];
    // String _orderID = message['order_id'];
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', channelDescription: 'your channel description', sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max, priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, _title, _body, platformChannelSpecifics, payload: "");

    // await fln.show(
    //     0,
    //     // message.title,
    //     message['title'],
    //     message['body'],
    //
    //     platform);

    // String _title = message['title'];
    // String _body = message['body'];
    // // String _orderID = message['order_id'];
    // BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
    //   _body, htmlFormatBigText: true,
    //   contentTitle: _title, htmlFormatContentTitle: true,
    // );
    //
    // AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    //   'big text channel id', 'big text channel name', channelDescription: 'big text channel description', importance: Importance.max,
    //   styleInformation: bigTextStyleInformation, priority: Priority.high, sound: RawResourceAndroidNotificationSound('notification'),
    // );
    // NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    // await fln.show(0, _title, _body, platformChannelSpecifics, payload: "");
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(Map<String, dynamic> message, FlutterLocalNotificationsPlugin fln) async {
    String _title = message['title'];
    String _body = message['body'];
    String _orderID = message['order_id'];
    String _image = message['image'].startsWith('http') ? message['image']
        : '${AppConstants.BASE_URL}/storage/app/public/notification/${message['image']}';
    final String largeIconPath = await _downloadAndSaveFile(_image, 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile(_image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath), hideExpandedLargeIcon: true,
      contentTitle: _title, htmlFormatContentTitle: true,
      summaryText: _body, htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'big text channel id', 'big text channel name', channelDescription: 'big text channel description',
      largeIcon: FilePathAndroidBitmap(largeIconPath), priority: Priority.high, sound: const RawResourceAndroidNotificationSound('notification'),
      styleInformation: bigPictureStyleInformation, importance: Importance.max,
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, _title, _body, platformChannelSpecifics, payload: _orderID);
  }

  static Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final Response response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));
    final File file = File(filePath);
    await file.writeAsBytes(response.data);
    return filePath;
  }

}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  print('background: ${message.data}');
  var androidInitialize = const AndroidInitializationSettings('app_icon');
  var iOSInitialize = IOSInitializationSettings();
  var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  MyNotification.showNotification(message.data, flutterLocalNotificationsPlugin);
}