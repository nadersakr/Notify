import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notify/core/style/app_colors.dart';
import 'package:notify/features/channel%20manipulation/presentation/view/screens/create_channel_screen.dart';
import 'package:notify/features/home%20screen/presentation/view/home_screen.dart';
import 'package:notify/features/notification/persentaion/view/notification_screen.dart';
import 'package:notify/features/profile/presentation/view/my%20profile/my_profile_screen.dart';
import 'package:notify/features/search/presentation/view/search_screen.dart';
import 'package:notify/features/nav%20menu/presentation/bloc/app_bloc.dart';
import 'package:notify/shared/domin/models/loaded_user.dart';
import 'package:notify/shared/domin/usecases/get_user_info.dart';

class NavMenu extends StatefulWidget {
  final int index;
  const NavMenu({
    super.key,
    this.index = 0,
  });

  @override
  NavMenuState createState() => NavMenuState();
}

class NavMenuState extends State<NavMenu> {
  int? _selectedIndex;
  @override
  void initState() {
    _selectedIndex = widget.index > 4 ? 0 : widget.index;
    super.initState();
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const CreateChannelScreen(),
    const NoificationScreen(),
    const MyProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  set onNavigate(int index) => _selectedIndex = index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc()
        ..add(GetStartUpAppDataEvent(
            usereInfoParams:
                GetUserInfoParams(userId: LoadedUserData().loadedUser!.id))),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: NavigationBar(
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              selectedIndex: _selectedIndex!,
              indicatorColor: Colors.transparent,
              onDestinationSelected: _onItemTapped,
              destinations: const [
                NavigationDestination(
                  selectedIcon: Icon(
                    Iconsax.home_trend_up,
                    color: AppColors.primaryColor,
                  ),
                  icon: Icon(Iconsax.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Iconsax.search_favorite,
                    color: AppColors.primaryColor,
                  ),
                  icon: Icon(Iconsax.search_normal_1),
                  label: 'Store',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Iconsax.add_square,
                    color: AppColors.primaryColor,
                  ),
                  icon: Icon(Iconsax.add),
                  label: 'Add',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Iconsax.notification_bing,
                    color: AppColors.primaryColor,
                  ),
                  icon: Icon(Iconsax.notification),
                  label: 'Chat',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Iconsax.user_tick,
                    color: AppColors.primaryColor,
                  ),
                  icon: Icon(Iconsax.user),
                  label: 'Profile',
                ),
              ],
            ),
            body: _screens[_selectedIndex!],
          );
        },
      ),
    );
  }
}
