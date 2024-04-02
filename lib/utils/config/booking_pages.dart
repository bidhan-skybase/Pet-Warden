import 'package:get/get.dart';
import 'package:petwarden/view/booking/pet_sitter_profile.dart';

final List<GetPage> bookingPages = <GetPage>[
  GetPage(
    name: PetSitterProfile.routeName,
    page: () => const PetSitterProfile(),
    binding: BindingsBuilder(
      () {
        // Get.lazyPut(() => HomePageController());
      },
    ),
  ),
];
