import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/main.dart';
import 'package:petwarden/model/sitters_model.dart';
import 'package:petwarden/repo/sitters_repo.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';
import 'package:petwarden/view/dash_pages/messages_screen.dart';

class PetSitterProfileController extends GetxController {
  Rxn<String> id = Rxn();
  Rxn<Sitters> sitter = Rxn();
  RxDouble rating = RxDouble(0.0);
  var reviewController = TextEditingController();
  List<ContextMenuEntry> entries = [];
  RxBool isLoading = false.obs;
  var cc = Get.find<CoreController>();

  @override
  void onInit() {
    var args = Get.arguments;
    if (args['id'] != null) {
      id.value = args['id'];
      getSitterDetail();
    }
    entries = <ContextMenuEntry>[
      const MenuHeader(text: "More"),
      MenuItem(
          label: 'Chat',
          icon: Icons.send,
          onSelected: () {
            Get.toNamed(MessagesScreen.routeName, arguments: {
              "reciverdetail": {
                "id": sitter.value?.userId,
                "name": sitter.value?.name,
                "chatRoomId": "${cc.currentUser.value?.id}_${sitter.value?.userId}",
                "image": sitter.value?.profileImageUrl ?? ""
              }
            });
          }),
      const MenuDivider(),
      MenuItem(
        label: 'Report',
        icon: Icons.flag,
        onSelected: () {},
      ),
    ];

    super.onInit();
  }

  void getSitterDetail() async {
    isLoading.value = true;
    await SittersRepo.getSitterDetail(
        id: id.value!,
        onSuccess: (sitter) {
          this.sitter.value = sitter;
          isLoading.value = false;
        },
        onError: (message) {
          isLoading.value = false;
          PetSnackBar.error(message: message);
        });
  }

  void addRating() {
    SittersRepo.addReview(
        ratings: rating.value,
        comment: reviewController.text,
        sitterId: sitter.value!.userId.toString(),
        onSuccess: (status) {
          Navigator.pop(Get.context!);
          getSitterDetail();
          PetSnackBar.success(
            title: "Hooray!",
            message: "Your review has been added successfully! 🎉",
          );
        },
        onError: (status) {
          Navigator.pop(Get.context!);
          PetSnackBar.error(
            title: "Oh no!",
            message: "Sorry, an unexpected error occurred. 😔",
          );
        });
  }
}
