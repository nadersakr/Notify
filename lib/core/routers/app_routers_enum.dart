enum AppRouteEnum { loginPage, signUpPage, homePage, navMenu, search,channelScreen }

extension AppRouteExtension on AppRouteEnum {
  String get name {
    switch (this) {
      case AppRouteEnum.loginPage:
        return "/login";

      case AppRouteEnum.signUpPage:
        return "/signup";
      case AppRouteEnum.homePage:
        return "/home";
      case AppRouteEnum.navMenu:
        return "/nav_menu";
      case AppRouteEnum.search:
        return "/search";
      case AppRouteEnum.channelScreen:
        return "/channel_screen";

      default:
        return "/login";
    }
  }
}
