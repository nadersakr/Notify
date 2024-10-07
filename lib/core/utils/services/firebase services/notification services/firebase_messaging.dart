import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:notify/core/utils/services/firebase%20services/notification%20services/notification_base_class.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:notify/shared/domin/models/loaded_user.dart';

class FirebaseNotificationService implements NotificationService {
  @override
  Future<String> getAccessToken() async {
    // Your client ID and client secret obtained from Google Cloud Console
    final serviceAccountJson = {
  "type": dotenv.env['TYPE'],
  "project_id": dotenv.env['PROJECT_ID'],
  "private_key_id": dotenv.env['PRIVATE_KEY_ID'],
  "private_key": dotenv.env['PRIVATE_KEY']?.replaceAll(r'\n', '\n'),
  "client_email": dotenv.env['CLIENT_EMAIL'],
  "client_id": dotenv.env['CLIENT_ID'],
  "auth_uri": dotenv.env['AUTH_URI'],
  "token_uri": dotenv.env['TOKEN_URI'],
  "auth_provider_x509_cert_url": dotenv.env['AUTH_PROVIDER_CERT_URL'],
  "client_x509_cert_url": dotenv.env['CLIENT_CERT_URL'],
};

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );
    // Obtain the access token
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
            scopes,
            client);
    // Close the HTTP client
    client.close();

    // Return the access token
    return credentials.accessToken.data;
  }

  @override
  Future<void> sendFCMMessage({
    required String token,
    required String title,
    required String body,
    String? imageUrl,
  }) async {
    final String serverKey = await getAccessToken(); // Your FCM server key
    const String fcmEndpoint =
        'https://fcm.googleapis.com/v1/projects/notify-afb86/messages:send';
    final currentFCMToken = await FirebaseMessaging.instance.getToken();
    print("fcmkey : $currentFCMToken");
    final Map<String, dynamic> message = {
      'message': {
        'token': token,
        'notification': {'body': body, 'title': title},
        'data': {
          'current_user_fcm_token':
              token, // Include the current user's FCM token in data payload
        },
      }
    };

    final http.Response response = await http.post(
      Uri.parse(fcmEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('FCM message sent successfully');
    } else {
      print('Failed to send FCM message: ${response.statusCode}');
    }
  }

  @override
  Future<void> sendFCMTopicMessage({
    required String topic,
    required String title,
    required String body,
    String? imageUrl,
    Map<String, dynamic>? data,
  }) async {
    print("====-----------------1");
    final String serverKey = await getAccessToken(); // Your FCM server key
    print("====-----------------2");
    const String fcmEndpoint =
        'https://fcm.googleapis.com/v1/projects/notify-afb86/messages:send';

    final Map<String, dynamic> message = {
      'message': {
        'topic': topic,
        'notification': {
          'title': title,
          'body': body,
          if (imageUrl != null) 'image': imageUrl,
        },
        if (data != null) 'data': data,
      }
    };

    final http.Response response = await http.post(
      Uri.parse(fcmEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('FCM topic message sent successfully');
    } else {
      print('Failed to send FCM topic message: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  @override
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
 Future<void> initialize() async {
  // Request notification permissions
  NotificationSettings settings = await _firebaseMessaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    debugPrint('User granted permission');

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Received a message while in the foreground!');
      if (message.notification != null) {
        debugPrint('Message also contained a notification: ${message.notification}');
      }
    });

    // Listen for messages opened from a terminated state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('A new onMessageOpenedApp event was published!');
      if (message.notification != null) {
        debugPrint('Message also contained a notification: ${message.notification}');
      }
    });

    // Retrieve and store the FCM token
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      LoadedUserData.notificationToken = token;
      debugPrint('User FCM token set: $token');
    } else {
      debugPrint('Failed to get FCM token');
    }
  } else {
    debugPrint('User declined or has not accepted permission');
  }
}

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    debugPrint('Handling a background message: ${message.messageId}');
  }
}
  


