import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = new StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future initializeApp() async {
    await Firebase.initializeApp();
    await requestPermission();
    /* token = await FirebaseMessaging.instance
        .getToken(); */ //Se obtine el token del dispositivo
    //print('token::: $token');
    FirebaseMessaging.onBackgroundMessage(_onBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenAppHandler);
    //return token;
  }

  static Future _onBackgroundHandler(RemoteMessage message) async {
  // print('message 1');
  // print('Menaje : ${message.notification!.body}');
  _messageStream.add( message.notification!.body?? 'Error: Notificación firebase' );
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    // print('message 2');
    // print('Menaje : ${message.notification!.body}');
    /* _notificationController.add(message);  */
    _messageStream.add( message.notification!.body ?? 'Error: Notificación firebase' );
  }

  static Future _onMessageOpenAppHandler(RemoteMessage message) async {
    // print('message 3');
    // print('Menaje : ${message.notification!.body}');
    /* _notificationController.add(message); */
    _messageStream.add(message.notification!.body ?? 'Error: Notificación firebase' );
  }

  /*  static _closeStream() {
    _notificationController.close();
  } */

  // Apple / Web
  static requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
    //print('User push notification status ${settings.authorizationStatus}');
  }
}
