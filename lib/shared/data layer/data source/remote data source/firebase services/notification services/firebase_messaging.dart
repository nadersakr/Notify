import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notify/core/utils/constant/app_secrits.dart';
import 'package:notify/shared/data%20layer/data%20source/remote%20data%20source/firebase%20services/notification%20services/notification_base_class.dart';
import 'package:notify/shared/domin/entities/loaded_user.dart';

class FirebaseNotificationService implements NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final String serverKey = AppSecrits.serverKey;
  @override
  Future<void> initialize() async {
    // Request permission for notifications (iOS-specific)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission for notifications');
    } else {
      debugPrint('User declined or has not accepted permission');
    }

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(
          'Received a foreground message: ${message.notification?.title}, ${message.notification?.body}');
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle message when the app is opened from a notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
          'Notification clicked and app opened: ${message.notification?.title}, ${message.notification?.body}');
    });

    LoadedUserData.notificationToken = await getToken();
    debugPrint("Token is ${LoadedUserData.notificationToken}");
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    debugPrint('Handling a background message: ${message.messageId}');
  }

  @override
  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
    debugPrint('Subscribed to topic: $topic');
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    debugPrint('Unsubscribed from topic: $topic');
  }

  @override
  Future<void> sendNotificationToToken({
    required String token,
    required String title,
    required String body,
    String? imageUrl,
  }) async {
    const String fcmEndpoint = 'https://fcm.googleapis.com/fcm/send';

    try {
      final response = await http.post(
        Uri.parse(fcmEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(<String, dynamic>{
          'to': token,
          'notification': <String, dynamic>{
            'title': title,
            'body': body,
            'image': imageUrl,
          },
          'priority': 'high',
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('Notification sent successfully.');
      } else {
        debugPrint(
            'Failed to send notification. Status code: ${response.statusCode}');
        debugPrint('Error: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error sending notification: $e');
    }
  }

  @override
  Future<void> sendNotificationToTopic({
    required String topic,
    required String title,
    required String body,
    String? imageUrl,
  }) async {
    const String fcmEndpoint = 'https://fcm.googleapis.com/fcm/send';

    try {
      final response = await http.post(
        Uri.parse(fcmEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(<String, dynamic>{
          'to': '/topics/$topic',
          'notification': <String, dynamic>{
            'title': title,
            'body': body,
            'image': imageUrl,
          },
          'priority': 'high',
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('Notification sent to topic successfully.');
      } else {
        debugPrint(
            'Failed to send notification to topic. Status code: ${response.statusCode}');
        debugPrint('Error: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error sending notification to topic: $e');
    }
  }
}
