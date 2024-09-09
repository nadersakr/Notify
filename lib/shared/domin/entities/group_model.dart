class Group {
  final int id;
  final int creatorId;
  final String name;
  final String describtion;
  final List<int> superVisorsId;
  final List<int> membersId;
  final String? imageUrl;
  const Group( 
      {required this.id,
      required this.name,
      required this.creatorId,
      required this.describtion,
      required this.superVisorsId,
      this.imageUrl,
      this.membersId = const []});
}

