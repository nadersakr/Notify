abstract class NotificationService {
  // Initialize the notification service (e.g., Firebase, push notification setup)
  Future<void> getAccessToken();

  // Method to send a notification to a specific user/device using their token
  Future<void> sendFCMMessage({
    required String token,
    required String title,
    required String body,
    String? imageUrl,
  });

  // Method to send a notification to a topic (multiple users)
  Future<void> sendFCMTopicMessage({
    required String topic,
    required String title,
    required String body,
    String? imageUrl,
  });

  // Method to subscribe the current device/user to a specific topic
  Future<void> subscribeToTopic(String topic);

  // Method to unsubscribe the current device/user from a specific topic
  Future<void> unsubscribeFromTopic(String topic);

}
