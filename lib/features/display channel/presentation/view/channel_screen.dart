import 'package:flutter/material.dart';
import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/entities/notification_model.dart';
import 'package:notify/shared/domin/entities/user_model.dart';

class ChannelScreen extends StatelessWidget {
  const ChannelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Channel channel = Channel(
      superVisorsId: ['d1'],
      creatorId: 'd1',
      id: '1',
      title: 'Flutter Dev Community',
      describtion: 'A place for Flutter developers to share knowledge and resources.',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/notify-afb86.appspot.com/o/uploads%2Fcompressed_1726716621961.jpg?alt=media&token=04dd8042-369f-4719-8598-fccbde8d466a',
      hexColor: '42a5f5',
      notifications: [
        NotificationModel(id: 'n1', message: 'New tutorial on state management available!', timestamp: DateTime.now().subtract(const Duration(minutes: 10))),
        NotificationModel(id: 'n2', message: 'Join our upcoming Flutter meetup!', timestamp: DateTime.now().subtract(const Duration(hours: 1))),
        NotificationModel(id: 'n3', message: 'Weekly coding challenge starts now!', timestamp: DateTime.now().subtract(const Duration(days: 1))),
      ],
    );

    List<UserModel> members = [
      UserModel(id: 'u1', fullName: 'Alice Johnson', email: 'alice@example.com', imageUrl: 'https://via.placeholder.com/150'),
      UserModel(id: 'u2', fullName: 'Bob Smith', email: 'bob@example.com', imageUrl: 'https://via.placeholder.com/150'),
      UserModel(id: 'u3', fullName: 'Charlie Brown', email: 'charlie@example.com', imageUrl: 'https://via.placeholder.com/150'),
    ];

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(channel.imageUrl!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 80,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    channel.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              channel.describtion,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Members:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // Members List
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(member.imageUrl!),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        member.fullName,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Join request logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(int.parse('0xff${channel.hexColor}')),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Join Channel',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Notifications:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: channel.notifications.length,
              itemBuilder: (context, index) {
                final notification = channel.notifications[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    title: Text(notification.message),
                    subtitle: Text(
                      notification.timestamp.toLocal().toString(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
