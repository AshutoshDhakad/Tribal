import 'package:get/get.dart';

import '../modules/BottomNavigationBar/bindings/bottom_navigation_bar_binding.dart';
import '../modules/BottomNavigationBar/views/bottom_navigation_bar_view.dart';
import '../modules/brandprofile/bindings/brandprofile_binding.dart';
import '../modules/brandprofile/views/brandprofile_view.dart';
import '../modules/createProfile/bindings/create_profile_binding.dart';
import '../modules/createProfile/views/create_profile_view.dart';
import '../modules/editProfile/bindings/edit_profile_binding.dart';
import '../modules/editProfile/views/edit_profile_view.dart';
import '../modules/explorePage/bindings/explore_page_binding.dart';
import '../modules/explorePage/views/explore_page_view.dart';
import '../modules/followers/bindings/followers_binding.dart';
import '../modules/followers/views/followers_view.dart';
import '../modules/following/bindings/following_binding.dart';
import '../modules/following/views/following_view.dart';
import '../modules/homePage1/bindings/home_page1_binding.dart';
import '../modules/homePage1/views/home_page1_view.dart';
import '../modules/homepage/bindings/homepage_binding.dart';
import '../modules/homepage/views/homepage_view.dart';
import '../modules/notificationsPage/bindings/notifications_page_binding.dart';
import '../modules/notificationsPage/views/notifications_page_view.dart';
import '../modules/profilePage/bindings/profile_page_binding.dart';
import '../modules/profilePage/views/profile_page_view.dart';
import '../modules/singleFeedPage/bindings/single_feed_page_binding.dart';
import '../modules/singleFeedPage/views/single_feed_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOMEPAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOMEPAGE,
      page: () => Homepage(),
      binding: HomepageBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const Homepage(),
      binding: HomepageBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAVIGATION_BAR,
      page: () => BottomNavigationBarView(),
      binding: BottomNavigationBarBinding(),
    ),
    GetPage(
      name: _Paths.HOME_PAGE1,
      page: () => HomePage1View(),
      binding: HomePage1Binding(),
    ),
    GetPage(
      name: _Paths.EXPLORE_PAGE,
      page: () => const ExplorePageView(),
      binding: ExplorePageBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS_PAGE,
      page: () => const NotificationsPageView(),
      binding: NotificationsPageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAGE,
      page: () => const ProfilePageView(),
      binding: ProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.SINGLE_FEED_PAGE,
      page: () => SingleFeedPageView(),
      binding: SingleFeedPageBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PROFILE,
      page: () => CreateProfileView(),
      binding: CreateProfileBinding(),
    ),
    GetPage(
      name: _Paths.BRANDPROFILE,
      page: () => BrandprofileView(),
      binding: BrandprofileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.FOLLOWERS,
      page: () => FollowersView(),
      binding: FollowersBinding(),
    ),
    GetPage(
      name: _Paths.FOLLOWING,
      page: () =>  FollowingView(),
      binding: FollowingBinding(),
    ),
  ];
}
