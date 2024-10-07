import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String fullName;
  // final String username;
  final String email;
  final String? imageUrl;
  final List<dynamic> joinedChannelsId;
  final List<dynamic> ownedChannels;
  final List<dynamic> notifiactions;
  UserModel(
      {
      // required this.username,
      required this.fullName,
      this.joinedChannelsId = const [],
      this.ownedChannels = const [],
      this.notifiactions = const [],
      this.imageUrl,
      required this.id,
      required this.email});

  factory UserModel.toJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      joinedChannelsId: json['channelsId'],
      // username: json['username'],
      notifiactions: json['notifications'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // 'username': username,
      'fullName': fullName,
      'email': email,
      'imageUrl': imageUrl,
      'channelsId': joinedChannelsId,
      'ownedChannels': ownedChannels,
      'notifications': notifiactions,
    };
  }

  UserModel.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        fullName = map['fullName'],
        // username = map['username'],
        email = map['email'],
        ownedChannels = map['ownedChannels'] ?? [],
        imageUrl = map['imageUrl'],
        notifiactions = map['notifications'] ?? [],
        joinedChannelsId = map['channelsId'];

  factory UserModel.fromFirebase(DocumentSnapshot doc, {required String id}) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: id,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      joinedChannelsId: data['joinedChannels'] ?? [],
      imageUrl: data['imageUrl'],
      ownedChannels: data['ownedChannels'] ?? [],
      notifiactions: data['notifications'] ?? [],
    );
  }
}
