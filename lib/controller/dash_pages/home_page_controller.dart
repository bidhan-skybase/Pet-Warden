import 'package:get/get.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/model/sitters_model.dart';
import 'package:petwarden/repo/sitters_repo.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';

class HomePageController extends GetxController {
  final cc = Get.find<CoreController>();
  RxString firstName = "".obs;
  RxString petName = "".obs;
  RxList<Sitters> sitters = <Sitters>[].obs;
  RxList<Sitters> featuredSitters = <Sitters>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getFirstName();
    getPetName();
    getFeaturedSitters();
    getSitters();

    super.onInit();
  }

  void getFirstName() {
    String fullName = cc.currentUser.value?.name ?? "";
    List<String> nameParts = fullName.split(" ");
    firstName.value = nameParts.isNotEmpty ? nameParts[0] : "";
  }

  void getPetName() {
    if (cc.pets.length > 1) {
      petName.value = "Your Pets";
    } else {
      String fullName = cc.pets.first.name ?? "";
      List<String> nameParts = fullName.split(" ");
      petName.value = nameParts.isNotEmpty ? nameParts[0] : "";
    }
  }

  void getSitters() async {
    isLoading.value = true;
    await SittersRepo.getPetSitters(onSuccess: (listOfSitters) {
      sitters.value = listOfSitters;
      isLoading.value = false;
    }, onError: (message) {
      isLoading.value = false;
      PetSnackBar.error(message: message);
    });
  }

  void getFeaturedSitters() async {
    isLoading.value = true;
    await SittersRepo.getFeaturedSitters(onSuccess: (listOfSitters) {
      featuredSitters.value = listOfSitters;
      isLoading.value = false;
    }, onError: (message) {
      isLoading.value = false;
      PetSnackBar.error(message: message);
    });
  }
}
