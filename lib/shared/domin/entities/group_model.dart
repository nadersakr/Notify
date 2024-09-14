class Channal {
  final int id;
  final int creatorId;
  final String title;
  final String describtion;
  final List<int> superVisorsId;
  final List<int> membersId;
  final String? imageUrl;
  final String hexColor;
  final int membersCount;

  const Channal(
      {required this.id,
      this.membersCount = 0,
      required this.title,
      required this.hexColor,
      required this.creatorId,
      required this.describtion,
      required this.superVisorsId,
      this.imageUrl,
      this.membersId = const []});
}
