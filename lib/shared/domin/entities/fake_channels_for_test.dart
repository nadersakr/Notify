import 'package:notify/shared/domin/entities/channel_model.dart';

final List<Channel> channelList = [
  const Channel(
    id: 1,
    creatorId: "101",
    membersCount: 50,
    title: 'Tech Enthusiasts',
    describtion:
        'A channel for tech lovers to share the latest in technology trends and news.',
    superVisorsId: [102, 103],
    membersId: [104, 105, 106],
    imageUrl: 'https://example.com/images/tech_enthusiasts.png',
    hexColor: 'FF5733',
  ),
  const Channel(
    id: 2,
    creatorId: "107",
    // membersCount: 1405,
    title: 'Fitness Freaks',
    describtion: 'Join us to discuss workouts, diet tips, and staying healthy.',
    superVisorsId: [108],
    membersId: [109, 110, 111, 112],
    imageUrl: 'https://example.com/images/fitness_freaks.png',
    hexColor: '33FF57',
  ),
  const Channel(
    id: 3,
    membersCount: 464,
    creatorId: "113",
    title: 'Movie Buffs',
    describtion: 'All about movies: discussions, recommendations, and more!',
    superVisorsId: [114, 115],
    membersId: [116, 117],
    imageUrl: 'https://example.com/images/movie_buffs.png',
    hexColor: '5733FF',
  ),
  const Channel(
    id: 4,
    creatorId: "118",
    membersCount: 752,
    title: 'Bookworms',
    describtion: 'For those who love reading and discussing books.',
    superVisorsId: [119],
    membersId: [120, 121, 122],
    imageUrl: 'https://example.com/images/bookworms.png',
    hexColor: 'FFD700',
  ),
  const Channel(
    id: 5,
    membersCount: 122,
    creatorId: "123",
    title: 'Travel Junkies',
    describtion:
        'A space to share travel experiences, tips, and destination ideas.',
    superVisorsId: [124],
    membersId: [125, 126, 127],
    imageUrl: 'https://example.com/images/travel_junkies.png',
    hexColor: '00CED1',
  ),
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
