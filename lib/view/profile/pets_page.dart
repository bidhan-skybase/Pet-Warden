import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/controller/profile/pet_detail_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
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
                    );
                  }),
              const SizedBox(
                height: 49,
              ),
              CustomElevatedButton(
                  onPressed: () {
                    Get.toNamed(AddPetProfile.routeName);
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
