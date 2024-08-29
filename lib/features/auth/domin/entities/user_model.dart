class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String? imageUrl;
  final List<String>? chanalsId;
  UserModel({required this.username, required this.firstName,required this.lastName,  this.chanalsId,this.imageUrl,required this.id, required this.email});

 factory UserModel.toJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      chanalsId: json['chanalsId'], username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'imageUrl': imageUrl,
      'chanalsId': chanalsId,
    };
  }

  UserModel.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        firstName = map['firstName'],
        lastName = map['lastName'],
        username = map['username'],
        email = map['email'],
        imageUrl = map['imageUrl'],
        chanalsId = map['chanalsId'];
}
