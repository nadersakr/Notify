import 'package:notify/core/network/error/failures.dart';
import 'package:notify/features/home%20screen/data%20layer/data%20source/remote/remote_data_source.dart';
import 'package:notify/features/home%20screen/domin/usecase/get_notification_data.dart';
import 'package:notify/shared/domin/entities/notification_model.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<Channel>> getBiggestChannels() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('channels')
        .orderBy('membersCount', descending: true)
        .limit(4)
        .get();
    return querySnapshot.docs.map((doc) => Channel.fromFirebase(doc)).toList();
  }

  @override
  Future<NotificationModel> getNotificationData(
      GetNotificationInfoParams params) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('notifications')
          .doc(params.notificationId)
          .get();
      return NotificationModel.fromFirebase(querySnapshot,
          id: params.notificationId);
    } on FirebaseException catch (e) {
      throw FirebaseErrorFailure(e.message.toString());
    } catch (e) {
      rethrow;
    }
  }
}
