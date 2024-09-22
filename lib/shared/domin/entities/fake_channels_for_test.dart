import 'package:notify/shared/domin/entities/channel_model.dart';
import 'package:notify/shared/domin/entities/notification_model.dart';
import 'package:notify/shared/domin/entities/user_model.dart';

final List<Channel> channelList = [
  const Channel(
    id: '1727006553242964',
    creatorId: "101",
    membersCount: 50,
    title: 'Tech Enthusiasts',
    description:
        'A channel for tech lovers to share the latest in technology trends and news.',
    supervisorsId: ['102', '103'],
    membersId: ['104', '105', '106'],
    imageUrl: 'https://example.com/images/tech_enthusiasts.png',
    hexColor: 'FF5733',
  ),
  const Channel(
    id: '1727006553242964',
    creatorId: "107",
    // membersCount: 1405,
    title: 'Fitness Freaks',
    description: 'Join us to discuss workouts, diet tips, and staying healthy.',
    supervisorsId: ['108'],
    membersId: ['109', '110', '111', '112'],
    imageUrl: 'https://example.com/images/fitness_freaks.png',
    hexColor: '33FF57',
  ),
  const Channel(
    id: '1727006553242964',
    membersCount: 464,
    creatorId: "113",
    title: 'Movie Buffs',
    description: 'All about movies: discussions, recommendations, and more!',
    supervisorsId: ['114', '115'],
    membersId: ['116', '117'],
    imageUrl: 'https://example.com/images/movie_buffs.png',
    hexColor: '5733FF',
  ),
  const Channel(
    id: '1727006553242964',
    creatorId: "118",
    membersCount: 752,
    title: 'Bookworms',
    description: 'For those who love reading and discussing books.',
    supervisorsId: ['119'],
    membersId: ['120', '121', '122'],
    imageUrl: 'https://example.com/images/bookworms.png',
    hexColor: 'FFD700',
  ),
  const Channel(
    id: '1727006553242964',
    membersCount: 122,
    creatorId: "123",
    title: 'Travel Junkies',
    description:
        'A space to share travel experiences, tips, and destination ideas.',
    supervisorsId: ['124'],
    membersId: ['125', '126', '127'],
    imageUrl: 'https://example.com/images/travel_junkies.png',
    hexColor: '00CED1',
  ),
];
Channel fakeChannel = Channel(
  //fake channel to load while waiting for the real data
  membersCount: 5,
  membersId: ['u1', 'u2', 'u3'],
  supervisorsId: ['d1, d2'],
  creatorId: 'd1',
  id: '2',
  title: 'Flutter Dev Community',
  description:
      'A place for Flutter developers to share knowledge and resources.',
  imageUrl:
      'https://firebasestorage.googleapis.com/v0/b/notify-afb86.appspot.com/o/uploads%2Fcompressed_1726716621961.jpg?alt=media&token=04dd8042-369f-4719-8598-fccbde8d466a',
  hexColor: 'FFFFBB01',
  notifications: [
    NotificationModel(
        id: 'n1',
        message: 'New tutorial on state management available!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 10))),
    NotificationModel(
        id: 'n2',
        message: 'Join our upcoming Flutter meetup!',
        timestamp: DateTime.now().subtract(const Duration(hours: 1))),
    NotificationModel(
        id: 'n3',
        message: 'Weekly coding challenge starts now!',
        timestamp: DateTime.now().subtract(const Duration(days: 1))),
    NotificationModel(
        id: 'n1',
        message: 'New tutorial on state management available!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 10))),
    NotificationModel(
        id: 'n2',
        message: 'Join our upcoming Flutter meetup!',
        timestamp: DateTime.now().subtract(const Duration(hours: 1))),
    NotificationModel(
        id: 'n3',
        message: 'Weekly coding challenge starts now!',
        timestamp: DateTime.now().subtract(const Duration(days: 1))),
  ],
);

List<UserModel> fakeMembers = [
  UserModel(
      id: 'u1',
      fullName: 'Alice Johnson',
      email: 'alice@example.com',
      imageUrl: 'https://via.placeholder.com/150'),
  UserModel(
      id: 'u2',
      fullName: 'Bob Smith',
      email: 'bob@example.com',
      imageUrl: 'https://via.placeholder.com/150'),
  UserModel(
      id: 'u1',
      fullName: 'Alice Johnson',
      email: 'alice@example.com',
      imageUrl: 'https://via.placeholder.com/150'),
  UserModel(
      id: 'u2',
      fullName: 'Bob Smith',
      email: 'bob@example.com',
      imageUrl: 'https://via.placeholder.com/150'),
];
// List<String> titles = [
//   "Sports",
//   "Health",
//   "Work",
//   "News",
// ];
// , "History" , "Culture" , "Environment" , "Society" , "Philosophy" , "Psychology" , "Literature" , "Language" , "Mathematics" , "Physics" , "Chemistry" , "Biology" , "Geology" , "Astronomy" , "Meteorology" , "Computer Science" , "Engineering" , "Medicine" , "Law" , "Economics" , "Sociology" , "Anthropology" , "Archaeology" , "Political Science" , "Criminology" , "Psychology" , "Linguistics" , "Education" , "History" , "Philosophy" , "Theology" , "Visual Arts" , "Performing Arts" , "Music" , "Literature" , "Film" , "Dance" , "Theatre" , "Architecture" , "Design" , "Graphic Design" , "Fashion Design" , "Interior Design" , "Urban Design" , "Landscape Architecture" , "Industrial Design" , "Game Design" , "Interaction Design" , "Web Design" , "Engineering" , "Aerospace Engineering" , "Agricultural Engineering" , "Biomedical Engineering" , "Chemical Engineering" , "Civil Engineering" , "Computer Engineering" , "Electrical Engineering" , "Environmental Engineering" , "Geotechnical Engineering" , "Industrial Engineering" , "Marine Engineering" , "Materials Engineering" , "Mechanical Engineering" , "Mining Engineering" , "Nuclear Engineering" , "Petroleum Engineering" , "Software Engineering" , "Structural Engineering" , "Systems Engineering" , "Transportation Engineering" , "Water Resources Engineering" , "Medicine" , "Anatomy" , "Anesthesiology" , "Cardiology" , "Critical Care Medicine" , "Dermatology" , "Emergency Medicine" , "Endocrinology" , "Family Medicine" , "Gastroenterology" , "Geriatrics" , "Hematology" , "Hepatology" , "Infectious Disease" , "Internal Medicine" ];
final List<String> fakeData = [
  'Sofa',
  'Chair',
  'Table',
  'Desk',
  'Bed',
  'Wardrobe',
  'Bookshelf',
  'TV Stand',
];
