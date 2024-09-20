import 'package:notify/shared/domin/entities/notification_model.dart';

class Channel {
  final String id;
  final String creatorId;
  final String title;
  final String describtion;
  final List<String> superVisorsId;
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
      required this.describtion,
      required this.superVisorsId,
      this.isPrivate = false,
      this.imageUrl,
      this.membersId = const [],
      this.notifications=const[]});
}
