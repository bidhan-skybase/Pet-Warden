import 'package:get/get.dart';
import 'package:petwarden/controller/auth/forgot_password_controller.dart';
import 'package:petwarden/controller/auth/login_controller.dart';
import 'package:petwarden/controller/staff/login_controller_sitter.dart';
import 'package:petwarden/controller/auth/otp_controller.dart';
import 'package:petwarden/controller/auth/sign_up_controller.dart';
import 'package:petwarden/controller/profile/change_password_controller.dart';
import 'package:petwarden/view/auth/OTPverification_page.dart';
import 'package:petwarden/view/auth/forgot_password.dart';
import 'package:petwarden/view/auth/log_in_screen.dart';
import 'package:petwarden/view/staff/log_in_screen_sitter.dart';
import 'package:petwarden/view/auth/sign_up_screen_pet.dart';
import 'package:petwarden/view/auth/sign_up_screen_user.dart';
import 'package:petwarden/view/profile/change_password.dart';

final List<GetPage> authPages = <GetPage>[
  GetPage(
      name: LogInScreen.routeName,
      page: () => LogInScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoginController());
      })),

  GetPage(
      name: SignUpPageUser.routeName,
      page: () => SignUpPageUser(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SignUpController());
      })),
  GetPage(
      name: SignUpPagePet.routeName,
      page: () => SignUpPagePet(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SignUpController());
      })),
  GetPage(
      name: OTPVerification.routeName,
      page: () => OTPVerification(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => OTPController());
      })),
  GetPage(
      name: ForgotPasswordScreen.routeName,
      page: () => ForgotPasswordScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ForgotPasswordController());
      })),
];
