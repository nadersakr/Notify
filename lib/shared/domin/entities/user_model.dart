class UserModel {
  final String id;
  final String fullName;
  // final String username;
  final String email;
  final String? imageUrl;
  final List<dynamic> channelsId;
  UserModel(
      {
      // required this.username,
      required this.fullName,
      this.channelsId=const[],
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
        imageUrl = map['imageUrl'],
        channelsId = map['channelsId'];
}
