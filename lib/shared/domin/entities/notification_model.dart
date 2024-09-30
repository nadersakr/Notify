class NotificationModel {
  final String id;
  final String message;
  final String? content;
  final String? imageUrl;
  final DateTime timestamp;

  NotificationModel({
    required this.id,
    required this.message,
    required this.timestamp,
    this.content,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'content': content,
      'imageUrl': imageUrl,
      'timestamp': timestamp,
    };
  }
}