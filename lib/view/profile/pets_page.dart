import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/controller/profile/pet_detail_controller.dart';
import 'package:petwarden/repo/profile_repo.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';
import 'package:petwarden/view/profile/add_pet_profile.dart';
import 'package:petwarden/view/profile/pet_details.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_network_image.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class PetsPage extends StatelessWidget {
  static var routeName = "/petsPage";

  const PetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    CoreController cc = Get.find<CoreController>();
    var allPets = cc.pets;
    return Scaffold(
      backgroundColor: PetWardenColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: PetWardenColors.backgroundColor,
        elevation: 0,
        surfaceTintColor: PetWardenColors.backgroundColor,
        leading: InkResponse(
          radius: 20,
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 24,
            color: PetWardenColors.buttonColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Pets",
          style: CustomTextStyles.f22W600(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: allPets.length,
                  itemBuilder: (context, index) {
                    var pet = allPets[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: InkWell(
                        onTap: () {
                          Get.offNamed(PetDetailScreen.routeName, arguments: {"pet": pet});
                        },
                        child: Slidable(
                          key: const ValueKey(0),
                          endActionPane:
                              ActionPane(extentRatio: 0.3, motion: const ScrollMotion(), children: [
                            SizedBox(
                              height: 220,
                              width: 100,
                              child: SlidableAction(
                                flex: 1,
                                onPressed: (value) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          "Confirm Delete",
                                          style:
                                              TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                        ),
                                        content: const Text(
                                          "Are you sure you want to delete this pet profile?",
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
                                                    ProfileRepo.deletePetProfile(
                                                        id: pet.id ?? "",
                                                        onComplete: (status) {
                                                          if (status) {
                                                            cc.loadCurrentPet();
                                                            // Get.back();
                                                            Get.back();
                                                            PetSnackBar.success(
                                                                title: "Goodbye, Pet",
                                                                message:
                                                                    "That pet’s outta here! Time to adopt a new buddy?");
                                                          }
                                                        });
                                                    // Navigator.pop(context);
                                                  },
                                                  title: "Continue",
                                                  textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                backgroundColor: PetWardenColors.errorColor,
                                foregroundColor: Colors.white,
                                label: "Delete",
                                icon: Icons.delete_outline,
                              ),
                            ),
                          ]),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: PetWardenColors.lightGrey),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(30),
                                    child: CustomNetworkImage(imageUrl: pet.imageUrl ?? ""),
                                  ),
                                ),
                                Text(
                                  pet.name ?? "",
                                  style: CustomTextStyles.f16W600(),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              const SizedBox(
                height: 49,
              ),
              CustomElevatedButton(
                  onPressed: () {
                    Get.offNamed(AddPetProfile.routeName);
                  },
                  title: "Add a pet"),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
