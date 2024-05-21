import 'package:get/get.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/model/sitter_staff_model.dart';
import 'package:petwarden/model/user_model.dart';

class SitterDetailController extends GetxController {
  final cc = Get.find<CoreController>();
  Rxn<SitterStaff> sitterInfo = Rxn();
  Rxn<User> user = Rxn();

  @override
  void onInit() {
    loadUserData();
    loadAdditionalData();
    super.onInit();
  }

  loadUserData() {
    
  }

  loadAdditionalData() {}
}
