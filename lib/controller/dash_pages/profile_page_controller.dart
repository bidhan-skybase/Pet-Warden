import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/model/user_model.dart';
import 'package:petwarden/repo/profile_repo.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';

import '../../utils/constants/colors.dart';

class ProfilePageController extends GetxController {
  var cc = Get.find<CoreController>();
  Rxn<User> user = Rxn();

  @override
  void onInit() {
    user.value = cc.currentUser.value;
    super.onInit();
  }

  void deleteAccount() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Confirm Delete",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            content: const Text(
              "Are you sure you want to delete this profile?",
              style: TextStyle(fontSize: 16),
            ),
            actions: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      buttonColor: PetWardenColors.backgroundColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      title: "Cancel",
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: PetWardenColors.textColor),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: CustomElevatedButton(
                      buttonColor: PetWardenColors.errorColor,
                      onPressed: () {
                        ProfileRepo.deleteAccount(onComplete: (status) {
                          if (status) {
                            cc.logOut();

                            // Get.back();
                            Get.back();
                          }
                        });
                        // Navigator.pop(context);
                      },
                      title: "Continue",
                      textStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}
