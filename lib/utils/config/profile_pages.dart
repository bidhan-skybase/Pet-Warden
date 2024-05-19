import 'package:get/get.dart';
import 'package:petwarden/controller/add_pet_profile_controller.dart';
import 'package:petwarden/controller/profile/change_password_controller.dart';
import 'package:petwarden/controller/profile/pet_detail_controller.dart';
import 'package:petwarden/controller/profile/pet_owner_detail_controller.dart';
import 'package:petwarden/view/profile/add_pet_profile.dart';
import 'package:petwarden/view/profile/change_password.dart';
import 'package:petwarden/view/profile/pet-owner_detail.dart';
import 'package:petwarden/view/profile/pet_details.dart';
import 'package:petwarden/view/profile/pets_page.dart';

final List<GetPage> profilePages = <GetPage>[
  GetPage(
      name: PetOwnerDetails.routeName,
      page: () => PetOwnerDetails(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PetOwnerDetailController());
      })),
  GetPage(
      name: PetDetailScreen.routeName,
      page: () => PetDetailScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PetDetailController());
      })),
  GetPage(
      name: ChangePassword.routeName,
      page: () => ChangePassword(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ChangePasswordController());
      })),
  GetPage(
      name: PetsPage.routeName,
      page: () => const PetsPage(),
      binding: BindingsBuilder(() {
        // Get.lazyPut(() => PetDetailController());
      })),
  GetPage(
      name: AddPetProfile.routeName,
      page: () => AddPetProfile(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AddPetController());
      })),
];
