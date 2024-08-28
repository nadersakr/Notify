enum AppRouteEnum {
  loginPage,
  signUpPage,
}

extension AppRouteExtension on AppRouteEnum {
  String get name {
    switch (this) {
      case AppRouteEnum.loginPage:
        return "/login";

      case AppRouteEnum.signUpPage:
        return "/signup";

      // case AppRouteEnum.weViewPage:
      //   return "/web_view_page";

      // case AppRouteEnum.photoViewPage:
      //   return "/photo_view_page";

      default:
        return "/login";
    }
  }
}
