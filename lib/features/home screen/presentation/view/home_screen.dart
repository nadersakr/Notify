import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notify/core/style/app_colors.dart';
import 'package:notify/core/style/app_text_style.dart';
import 'package:notify/core/utils/constant/app_strings.dart';
import 'package:notify/features/home%20screen/presentation/controllers/home_screen_controller.dart';
import 'package:notify/features/home%20screen/presentation/view/widgets/head_line_upove_chanals.dart';
import 'package:notify/shared/domin/entities/group_model.dart';
import 'package:notify/shared/domin/entities/loaded_user.dart';
import 'package:notify/shared/domin/entities/user_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeScreenController controller = HomeScreenController();
    UserModel user = LoadedUserData().loadedUser!;
    debugPrint(user.fullName);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(Iconsax.logout),
              onPressed: () {
                controller.logOut(context);
              },
            )
          ],
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: controller.widgetsWidth,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.appName,
                    style: AppTextStyle.xxxLargeBlack.copyWith(
                      letterSpacing: controller.letterSpace,
                    ),
                  ),
                  SizedBox(
                    height: controller.paddingSpace,
                  ),
                  TextLineUpoveChanals(
                    headLineText: controller.yourGroupHeadLine,
                    actionWidget: TextButton(
                        onPressed: () {},
                        child: Text(controller.seeAllString,
                            style: AppTextStyle.mediumBlack)),
                  ),
                  Container(
                    height: controller.yourGroupsContainerHeight,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: chanalList.length,
                      itemBuilder: (context, index) {
                        Chanal chanal = chanalList[index];

                        final Color color =
                            Color(int.parse('0xFF${chanal.hexColor}'));

                        return Container(
                          width: 100.w,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: color,
                            ),
                            // color: color.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(children: [
                            // blur
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(),
                              ),
                            ),
                            Center(
                              child: Text(
                                chanal.name,
                                textAlign: TextAlign.center,
                                style: AppTextStyle.smallBoldBlack.copyWith(
                                  letterSpacing: controller.letterSpace,
                                ),
                              ),
                            ),
                          ]),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: controller.paddingSpace,
                  ),
                  TextLineUpoveChanals(
                    headLineText: "Bigest Channels",
                    actionWidget: IconButton(
                      icon: const Icon(Iconsax.search_normal_1),
                      iconSize: 24.sp,
                      color: AppColors.gray,
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    height: controller.bigestchannalContainerHeight,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView.builder(
                      itemCount: chanalList.length,
                      itemBuilder: (context, index) {
                        final Chanal chanal = chanalList[index];
                        return Container(
                          height: controller.yourGroupsContainerHeight,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    Color(int.parse('0xFF${chanal.hexColor}'))),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    chanal.name,
                                    textAlign: TextAlign.left,
                                    style: AppTextStyle.smallBoldBlack.copyWith(
                                      letterSpacing: controller.letterSpace,
                                    ),
                                  ),
                                  const Spacer(),
                                  // member count
                                  Text("${chanal.membersCount}"),
                                  
                                  const Icon(
                                    Iconsax.user,
                                    size: 18,
                                  )
                                ],
                              ),
                              Text(
                                chanal.describtion.length > 50
                                    ? '${chanal.describtion.substring(0, 50)}'
                                        '..'
                                    : chanal.describtion,
                                style: AppTextStyle.smallBlack,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final List<Chanal> chanalList = [
  const Chanal(
    id: 1,
    creatorId: 101,
    membersCount: 50,
    name: 'Tech Enthusiasts',
    describtion:
        'A channel for tech lovers to share the latest in technology trends and news.',
    superVisorsId: [102, 103],
    membersId: [104, 105, 106],
    imageUrl: 'https://example.com/images/tech_enthusiasts.png',
    hexColor: 'FF5733',
  ),
  const Chanal(
    id: 2,
    creatorId: 107,
    // membersCount: 1405,
    name: 'Fitness Freaks',
    describtion: 'Join us to discuss workouts, diet tips, and staying healthy.',
    superVisorsId: [108],
    membersId: [109, 110, 111, 112],
    imageUrl: 'https://example.com/images/fitness_freaks.png',
    hexColor: '33FF57',
  ),
  const Chanal(
    id: 3,
    membersCount: 464,
    creatorId: 113,
    name: 'Movie Buffs',
    describtion: 'All about movies: discussions, recommendations, and more!',
    superVisorsId: [114, 115],
    membersId: [116, 117],
    imageUrl: 'https://example.com/images/movie_buffs.png',
    hexColor: '5733FF',
  ),
  const Chanal(
    id: 4,
    creatorId: 118,
    membersCount: 752,
    name: 'Bookworms',
    describtion: 'For those who love reading and discussing books.',
    superVisorsId: [119],
    membersId: [120, 121, 122],
    imageUrl: 'https://example.com/images/bookworms.png',
    hexColor: 'FFD700',
  ),
  const Chanal(
    id: 5,
    membersCount: 122,
    creatorId: 123,
    name: 'Travel Junkies',
    describtion:
        'A space to share travel experiences, tips, and destination ideas.',
    superVisorsId: [124],
    membersId: [125, 126, 127],
    imageUrl: 'https://example.com/images/travel_junkies.png',
    hexColor: '00CED1',
  ),
];

// List<String> names = [
//   "Sports",
//   "Health",
//   "Work",
//   "News",
// ];
// , "History" , "Culture" , "Environment" , "Society" , "Philosophy" , "Psychology" , "Literature" , "Language" , "Mathematics" , "Physics" , "Chemistry" , "Biology" , "Geology" , "Astronomy" , "Meteorology" , "Computer Science" , "Engineering" , "Medicine" , "Law" , "Economics" , "Sociology" , "Anthropology" , "Archaeology" , "Political Science" , "Criminology" , "Psychology" , "Linguistics" , "Education" , "History" , "Philosophy" , "Theology" , "Visual Arts" , "Performing Arts" , "Music" , "Literature" , "Film" , "Dance" , "Theatre" , "Architecture" , "Design" , "Graphic Design" , "Fashion Design" , "Interior Design" , "Urban Design" , "Landscape Architecture" , "Industrial Design" , "Game Design" , "Interaction Design" , "Web Design" , "Engineering" , "Aerospace Engineering" , "Agricultural Engineering" , "Biomedical Engineering" , "Chemical Engineering" , "Civil Engineering" , "Computer Engineering" , "Electrical Engineering" , "Environmental Engineering" , "Geotechnical Engineering" , "Industrial Engineering" , "Marine Engineering" , "Materials Engineering" , "Mechanical Engineering" , "Mining Engineering" , "Nuclear Engineering" , "Petroleum Engineering" , "Software Engineering" , "Structural Engineering" , "Systems Engineering" , "Transportation Engineering" , "Water Resources Engineering" , "Medicine" , "Anatomy" , "Anesthesiology" , "Cardiology" , "Critical Care Medicine" , "Dermatology" , "Emergency Medicine" , "Endocrinology" , "Family Medicine" , "Gastroenterology" , "Geriatrics" , "Hematology" , "Hepatology" , "Infectious Disease" , "Internal Medicine" ];