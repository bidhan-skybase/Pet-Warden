import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/model/user_model.dart';

class ProfilePageController extends GetxController {
  var cc = Get.find<CoreController>();
  Rxn<User> user = Rxn();

  @override
  void onInit() {
    user.value = cc.currentUser.value;
    super.onInit();
  }
}
