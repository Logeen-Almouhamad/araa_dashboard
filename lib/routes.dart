
import 'package:archiarena/view/auth/login_screen/login_screen.dart';
import 'package:archiarena/view/home/home_screens/home_screen.dart';
import 'package:archiarena/view/layout/main_layout.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'core/constant/routes.dart';
import 'bindings/initial_bindings.dart';

List<GetPage<dynamic>> routes = [
  ///Login Screen
  // GetPage(name: AppRoutes.mainScreen, page: () => MainScreen()),
  GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),

  // GetPage(name: AppRoutes.createAccountScreen, page: () => CreateAccount()),
  // GetPage(name: AppRoutes.birthdayScreen, page: () => BirthdayScreen()),
  // GetPage(name: AppRoutes.mobileNumberScreen, page: () => MobileNumberScreen()),
  // GetPage(name: AppRoutes.passwordScreen, page: () => PasswordScreen()),
  // GetPage(name: AppRoutes.privacyScreen, page: () => PrivacyScreen()),
  GetPage(name: AppRoutes.homeScreen, page: () => HomeScreen()),
 // GetPage(name: AppRoutes.projectScreen, page: () => ProjectScreen()),
  GetPage(name: AppRoutes.mainLayout, page: () => MainLayout()),
];