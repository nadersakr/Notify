import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notify/shared/domin/models/notification_model.dart';

class Channel {
  final String id;
  final String creatorId;
  final String title;
  final String description;
  final List<String> supervisorsId;
  final List<String> membersId;
  final String? imageUrl;
  final String hexColor;
  final int membersCount;
  final bool? isPrivate;
  final List<NotificationModel> notifications;

  const Channel(
      {required this.id,
      this.membersCount = 0,
      required this.title,
      required this.hexColor,
      required this.creatorId,
      required this.description,
      required this.supervisorsId,
      this.isPrivate = false,
      this.imageUrl,
      this.membersId = const [],
      this.notifications = const []});

  factory Channel.fromFirebase(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Channel(
      id: data['id'] != null ? "${data['id']}" : '',
      creatorId: data['ownerId'] ?? '',
      title: data['name'] ?? '',
      description: data['description'] ?? '',
      hexColor: data['color'] ?? '',
      isPrivate: data['isPrivate'] ?? false,
      imageUrl: data['imageUrl'],
      membersCount: data['membersCount'] ?? 0,
      supervisorsId: List<String>.from(data['supervisorsId'] ?? []),
      membersId: List<String>.from(data['membersId'] ?? []),
      notifications: [], // You might want to fetch or pass notifications differently
    );
  }
}
