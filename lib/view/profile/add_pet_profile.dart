import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petwarden/controller/add_pet_profile_controller.dart';
import 'package:petwarden/controller/auth/sign_up_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/helper/image_picker_helper.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';
import 'package:petwarden/utils/validators.dart';
import 'package:petwarden/view/auth/OTPverification_page.dart';
import 'package:petwarden/widgets/custom/custom_drop_down.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_network_image.dart';
import 'package:petwarden/widgets/custom/custom_radio_button.dart';
import 'package:petwarden/widgets/custom/custom_text_field.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class AddPetProfile extends StatelessWidget {
  static const routeName = "/addpet";
  final c = Get.find<AddPetController>();
  AddPetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Form(
              key: c.signupKeyPet,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Pet",
                    style: CustomTextStyles.f28W700(color: PetWardenColors.primaryColor),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Enter your pet details for adding a pet to  ',
                      style: CustomTextStyles.f14W600(color: PetWardenColors.highlightTextColor),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Pet Warden',
                            style: CustomTextStyles.f14W600(color: PetWardenColors.buttonColor)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 43,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 120,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: const Icon(
                                        Icons.camera,
                                        color: PetWardenColors.primaryColor,
                                      ),
                                      title: const Text("Camera"),
                                      onTap: () {
                                        ImageHelper.pickImage(
                                            imageSource: ImageSource.camera,
                                            onPickImage: (pickedImage) {
                                              c.pickImagePet(pickedImage);
                                            });
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(
                                        Icons.photo,
                                        color: PetWardenColors.primaryColor,
                                      ),
                                      title: const Text("Gallery"),
                                      onTap: () {
                                        ImageHelper.pickImage(
                                            imageSource: ImageSource.gallery,
                                            onPickImage: (pickedImage) {
                                              c.pickImagePet(pickedImage);
                                            });
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Stack(alignment: Alignment.bottomRight, children: [
                        Obx(() => c.petPicPath.value == ""
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: const CustomNetworkImage(
                                  imageUrl: "",
                                  height: 100,
                                  width: 100,
                                ),
                              )
                            : Visibility(
                                // visible: c.imageFileString.value.isNotEmpty,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.memory(
                                    base64Decode(c.petPicPath.value),
                                    filterQuality: FilterQuality.high,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.white,
                                size: 28,
                              ),
                              Icon(
                                Icons.circle,
                                color: PetWardenColors.primaryColor,
                                size: 26,
                              ),
                              Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 15,
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                  ),
                  const SizedBox(
                    height: 43,
                  ),
                  CustomTextField(
                      hint: "Pet name",
                      controller: c.petNameController,
                      textInputAction: TextInputAction.next,
                      validator: Validators.checkFieldEmpty,
                      textInputType: TextInputType.text),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => SizedBox(
                          width: Get.width / 3,
                          child: CustomDropdownFormField(
                            items: c.petTypes,
                            value: c.selectedPetType.value,
                            onChanged: (value) {
                              c.selectedPetType.value = value.toString();
                              c.updateBreeds(); // Update breeds when pet type changes
                            },
                          ),
                        ),
                      ),
                      Obx(
                        () => SizedBox(
                          width: Get.width / 2,
                          child: CustomDropdownFormField(
                            items: c.breeds,
                            value: c.selectedBreed.value,
                            onChanged: (value) {
                              c.selectedBreed.value = value.toString();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width / 3,
                        child: CustomTextField(
                            hint: "Age",
                            controller: c.petAgeController,
                            textInputAction: TextInputAction.next,
                            validator: Validators.checkFieldEmpty,
                            textInputType: TextInputType.number),
                      ),
                      Row(
                        children: [
                          Obx(() => SkyRadioButton(
                              value: "Male",
                              groupVlaue: c.selectedGender.value,
                              onTap: c.changeGender,
                              title: "Male")),
                          Obx(() => SkyRadioButton(
                              value: "Female",
                              groupVlaue: c.selectedGender.value,
                              onTap: c.changeGender,
                              title: "Female")),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Obx(
                    () => SizedBox(
                      width: Get.width,
                      child: CustomDropdownFormField(
                        items: c.vaccinationStatus,
                        value: c.selectedVaccinationStatus.value,
                        hint: "Vaccination Status",
                        onChanged: (value) {
                          c.selectedVaccinationStatus.value = value.toString();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextField(
                      maxLines: 5,
                      hint: "Habits and preferences",
                      controller: c.habitsController,
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.text),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomElevatedButton(
                    onPressed: () {
                      if (c.petPicPath.isEmpty) {
                        PetSnackBar.info(
                            title: "Oops! 🐾",
                            message:
                                "Can't proceed without adding your profile picture. Let's make your pet's profile shine!");
                      } else if (c.signupKeyPet.currentState!.validate()) {
                        // c.ownerSignUp();
                        c.createPetProfile();
                      }
                    },
                    title: "Next",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
