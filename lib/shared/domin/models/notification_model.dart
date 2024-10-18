import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String id;
  final String message;
  final String? channelId;
  final String? imageUrl;
  final DateTime? timestamp;
  final String? hexColor;
  final String? channelTitle;

  NotificationModel({
    required this.id,
    required this.message,
    this.timestamp,
    this.channelId,
    this.imageUrl,
    this.hexColor,
    this.channelTitle,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'imageUrl': imageUrl,
      'timestamp': timestamp,
    };
  }

  factory NotificationModel.fromFirebase(DocumentSnapshot doc,
      {required String id}) {
    final data = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      id: id,
      message: data['message'] ?? '',
      imageUrl: data['imageUrl'] ?? "",
      channelId: data['channelId'] ?? "",
      hexColor: data['hexColor'] ?? "",
      channelTitle: data['channelTitle'] ?? "Channel Title",
      timestamp: data['timestamp'] != null
          ? (data['timestamp'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
}
