import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:get/get.dart';
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
              "id": sitter.value!.id!.toString(),
              "name": sitter.value!.name!.toString()
            }
          });
        },
      ),
      const MenuDivider(),
      MenuItem(
        label: 'Report',
        icon: Icons.flag,
        onSelected: () {},
      ),
    ];

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

  void addRating() {
    SittersRepo.addReview(
        ratings: rating.value,
        comment: reviewController.text,
        sitterId: sitter.value!.userId.toString(),
        onSuccess: (status) {
          PetSnackBar.success(
            title: "Hooray!",
            message: "Your review has been added successfully! 🎉",
          );

          Get.back();
        },
        onError: (status) {
          PetSnackBar.error(
            title: "Oh no!",
            message: "Sorry, an unexpected error occurred. 😔",
          );
          Get.back();
        });
  }

// initialize a context menu
}
