import 'package:get/get.dart';
import 'package:petwarden/controller/core_controller.dart';

class HomePageController extends GetxController {
  final cc = Get.find<CoreController>();
  RxString firstName = "".obs;

  @override
  void onInit() {
    getFirstName();
    super.onInit();
  }

//   String fullName = cc.currentUser.value?.name ?? "";
// List<String> nameParts = fullName.split(" ");
// String firstName = nameParts.isNotEmpty ? nameParts[0] : "";

  void getFirstName() {
    String fullName = cc.currentUser.value?.name ?? "";
    List<String> nameParts = fullName.split(" ");
    firstName.value = nameParts.isNotEmpty ? nameParts[0] : "";
  }
}
