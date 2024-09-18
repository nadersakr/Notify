class Channel {
  final int id;
  final String creatorId;
  final String title;
  final String describtion;
  final List<int> superVisorsId;
  final List<int> membersId;
  final String? imageUrl;
  final String hexColor;
  final int membersCount;
  final bool? isPrivate;

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
      this.membersId = const []});
}
