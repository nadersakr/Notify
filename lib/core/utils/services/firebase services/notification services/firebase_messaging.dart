import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notify/core/utils/services/firebase%20services/notification%20services/notification_base_class.dart';
import 'package:notify/shared/domin/entities/loaded_user.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

class FirebaseNotificationService implements NotificationService {
  Future<String> getAccessToken() async {
    // Your client ID and client secret obtained from Google Cloud Console
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "notify-afb86",
      "private_key_id": "8c5bcd8808910496c938ec1901fbfd947733953a",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCWBHxNB3iwjvV4\nO9DLK7FFBLaFfeSqVKiBmdip6IctMZz2mB27Jb0W0KgdD0aMSwbs5SBrvySdVDbt\npyDHAo+6UhncHiBWxg3ozZhcjTiwAsIqEQI4jOx9C8Okd2k9/US2J+Y7520R/EBx\nfZ/iBMnRw9H5b867fsH/JesKLrSbd2UsuY7T/4rb83kOkG217ewLLsWd98JPdoid\nhH1+adbty+1nMiOV1xl/Ge4M9erlEvcokDyFQeYhs5fb69aVMPNwcQ94MRtDGu4d\nhPIAX1r49EwVTiVhD+csA28lyl8Y5WGEpCnC+hVcj4Y/JFWgkkG3UV50LmMbMCgS\n8deGWKSDAgMBAAECggEACt59VD/P1NiVKWZwD/n07vK5KxfX4Vo4sT2NaKLbzgCN\nUxwdv1Yr8PZVaXGWlqPGKmDGRhHQ9c/8Gm2xXsN6C8sjnrXVRjEB7fwDZ37ZFhhe\nqzL7R0/SjJOb7Ua0XdTqGkAiASh/cXFACNj/JGspy8rVY+F5bk7WgGvlySGUKiIf\nS9PDo/qhIaSWoUC7saiJVr3SaQu6WlCU37djwibB96BLCM0HWfvnT5KePjptORUX\nO5fNiZQqtt45ep+sdksmFtJtJdAkPUB38nCsVEV1iF6rX6PkCUOltLysW7r1LAZD\n5VIJzXe64V0R/wVy5LiUrgO2LINZrK70n/miH1djiQKBgQDLq5wQ2SyOQ2sSWdbX\nrh0ecg8IDbjJ1hDyvsiXzaObiku0JbDbUi20AWJCAeW0jL611eqBYyJrALn6SyB9\n9D8/3+OZ9JZ9VbBRUuuLNhaZ+YXV+//4+SgkguHhz9OiVvTP92yqfunzrIr5ktjf\nbNdyjaDM1e/0y0ctdh1S3lv62QKBgQC8j95DcsjViV8B6VSzGJYuuxjq5WgRwI+9\nzeYJrQmIKGGBbO9L4vrnahX3gnPDBFzXxVTWNFtBfinSqFSRp8OA4FKsPXZfgY+e\nfp9a9CIFl06k8bk+G7hkpA2wvxAetEPeuvdlwkIBP3KrzE0VcFSaty1BpWhh0CSa\nHvsaxpqouwKBgEi4dXjukiIZoFllCnjoCi2cvBE8FQa8EEEcLbNGEWyv7GfeLU+h\n//+Nnu/CjanxtwZl4t1f8CIUmFLuECPo2cyMvE90LWeC+PmQidmi7l774PWOjM7w\n54xhzxU5h28nbTH0PjCCMDZ5HQYPkK/1xNd6CjgZCxx0mG17Bu1Xx6/BAoGAM/EZ\nk9DZu+DEeB1TRKaAME0/tu0Mtt8peWpvdLjiyEv/WAyu+mODJB4YAP9BbjYUcSed\nkAgKH0dms+3Epf7lnumsPGAN7I8fBdTxhrd7a7jbZBpmIdK2/5olX0uyYBLeI0uz\nfKd/USKuLt7vWPmBhMDyyYOL9m3Et2PTXfPZhKMCgYBfjGxZTlWeS/iPrP2o20zs\nDfgEOgJdfAj1DCsgZGe4LMBIl2WzQhI1isZgYKbbuaOJZBRvgZQ/48jmk5FjrhzO\nU/XZzlKvyFg3QuMSIEji+u0970TKBadjXnJu4p5Rb9WoGqWv/kI0T+Tw1TiFfLld\nChh2/1ke0xQFAtxwDErqYA==\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-5x9th@notify-afb86.iam.gserviceaccount.com",
      "client_id": "115576278452177368843",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-5x9th%40notify-afb86.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
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

  Future<void> sendFCMMessage(
    {
      required String token,
      required String title,
      required String body,
      String? imageUrl,

    }
  ) async {
    final String serverKey = await getAccessToken(); // Your FCM server key
    const String fcmEndpoint =
        'https://fcm.googleapis.com/v1/projects/notify-afb86/messages:send';
    final currentFCMToken = await FirebaseMessaging.instance.getToken();
    print("fcmkey : $currentFCMToken");
    final Map<String, dynamic> message = {
      'message': {
        'token':token,        'notification': {
          'body': body,
          'title': title
        },
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
Future<void> sendFCMTopicMessage({
  required String topic,
  required String title,
  required String body,
  Map<String, dynamic>? data,
}) async {
  final String serverKey = await getAccessToken(); // Your FCM server key
  const String fcmEndpoint =
      'https://fcm.googleapis.com/v1/projects/notify-afb86/messages:send';

  final Map<String, dynamic> message = {
    'message': {
      'topic': topic,
      'notification': {
        'title': title,
        'body': body,
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
    final String serverKey = await getAccessToken(); // Your FCM server key
    const String fcmEndpoint =
        'https://fcm.googleapis.com/v1/projects/notify-afb86/messages:send';
    final currentFCMToken = await FirebaseMessaging.instance.getToken();
    print("fcmkey : $currentFCMToken");
    final Map<String, dynamic> message = {
      'message': {
        'token':
            currentFCMToken, // Token of the device you want to send the message to
        'notification': {'body': body, 'title': title},
        'data': {
          'current_user_fcm_token':
              currentFCMToken, // Include the current user's FCM token in data payload
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
  Future<void> sendNotificationToTopic({
    required String topic,
    required String title,
    required String body,
    String? imageUrl,
  }) async {
    final String serverKey = await getAccessToken(); // Your FCM server key
    const String fcmEndpoint =
        'https://fcm.googleapis.com/v1/projects/notify-afb86/messages:send';
    final currentFCMToken = await FirebaseMessaging.instance.getToken();
    print("fcmkey : $currentFCMToken");
    final Map<String, dynamic> message = <String, dynamic>{
      'to': '/topics/$topic',
      'notification': <String, dynamic>{
        'title': title,
        'body': body,
        'image': imageUrl,
      },
      'priority': 'high',
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

}
// my mobile token 
// eJzGSfsJT92a-Y35eQKBZ2:APA91bG4SyYbbIOt8S7MkORKo6BrtthmrTLRvMyzOVHbBTTCvQc1GOBHSKDipXDFrM_F2xQ5lUecODkY0lDIoY6gsVzKd1rtkixMCtUOYOKHkxvlk8jK9swEg8zT1Tb-gyWo3Vfp0Zcb