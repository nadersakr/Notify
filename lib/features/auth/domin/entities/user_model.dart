class UserModel {
  final String id;
  final String name;
  final String email;
  final String? imageUrl;
  final List<String>? chanalsId;
  UserModel( {this.chanalsId,this.imageUrl,required this.id, required this.name, required this.email});
}
