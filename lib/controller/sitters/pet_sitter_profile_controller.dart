import 'package:get/get.dart';
import 'package:petwarden/main.dart';
import 'package:petwarden/model/sitters_model.dart';
import 'package:petwarden/repo/sitters_repo.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';

class PetSitterProfileController extends GetxController {
  Rxn<String> id = Rxn();
  Rxn<Sitters> sitter = Rxn();
  @override
  void onInit() {
    var args = Get.arguments;
    if (args['id'] != null) {
      id.value = args['id'];
      getSitterDetail();
    }

    super.onInit();
  }

  void getSitterDetail() {
    SittersRepo.getSitterDetail(
        id: id.value!,
        onSuccess: (sitter) {
          this.sitter.value = sitter;
        },
        onError: (message) {
          PetSnackBar.error(message: message);
        });
  }
}
