import 'package:get/get.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/model/sitters_model.dart';
import 'package:petwarden/repo/sitters_repo.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';

class HomePageController extends GetxController {
  final cc = Get.find<CoreController>();
  RxString firstName = "".obs;
  List<Sitters> sitters = [];

  @override
  void onInit() {
    getFirstName();
    getSitters();
    super.onInit();
  }

  void getFirstName() {
    String fullName = cc.currentUser.value?.name ?? "";
    List<String> nameParts = fullName.split(" ");
    firstName.value = nameParts.isNotEmpty ? nameParts[0] : "";
  }

  void getSitters() {
    SittersRepo.getPetSitters(onSuccess: (listOfSitters) {
      sitters = listOfSitters;
    }, onError: (message) {
      PetSnackBar.error(message: message);
    });
  }
}
