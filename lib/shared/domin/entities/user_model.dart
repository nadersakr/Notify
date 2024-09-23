import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String fullName;
  // final String username;
  final String email;
  final String? imageUrl;
  final List<dynamic> channelsId;
  final List<dynamic> ownedChannels;
  UserModel(
      {
      // required this.username,
      required this.fullName,
      this.channelsId = const [],
      this.ownedChannels = const [],
      this.imageUrl,
      required this.id,
      required this.email});

  factory UserModel.toJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      channelsId: json['channelsId'],
      // username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // 'username': username,
      'fullName': fullName,
      'email': email,
      'imageUrl': imageUrl,
      'channelsId': channelsId,
    };
  }

  UserModel.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        fullName = map['fullName'],
        // username = map['username'],
        email = map['email'],
        ownedChannels = map['ownedChannels']??[],
        imageUrl = map['imageUrl'],
        channelsId = map['channelsId'];

  factory UserModel.fromFirebase(DocumentSnapshot doc, {required String id}) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: id,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      channelsId: data['joinedChannels'] ?? [],
      imageUrl: data['imageUrl']??"",
      ownedChannels: data['ownedChannels'] ?? [],
    );
  }
}
