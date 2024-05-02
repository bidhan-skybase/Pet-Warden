import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/auth/sign_up_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/validators.dart';
import 'package:petwarden/view/auth/OTPverification_page.dart';
import 'package:petwarden/widgets/custom/custom_drop_down.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_radio_button.dart';
import 'package:petwarden/widgets/custom/custom_text_field.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class SignUpPagePet extends StatelessWidget {
  static const routeName = "/signup-pet";
  final c = Get.find<SignUpController>();
  SignUpPagePet({super.key});

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign Up",
                  style: CustomTextStyles.f28W700(color: PetWardenColors.primaryColor),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Enter your pet details for signing to  ',
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
                  child: Stack(alignment: Alignment.bottomRight, children: [
                    GestureDetector(
                        onTap: c.pickImage,
                        child: Obx(
                          () => CircleAvatar(
                            radius: 60,
                            backgroundImage: c.petPicPath.value == 'http://surl.li/rkdax'
                                ? NetworkImage(c.petPicPath.value)
                                : FileImage(File(c.petPicPath.value)) as ImageProvider<Object>,
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
                          hint: "Select pet type",
                          onChanged: (value) {
                            c.selectedPetType.value = value.toString();
                          },
                        ),
                      ),
                    ),
                    Obx(
                      () => SizedBox(
                        width: Get.width / 2,
                        child: CustomDropdownFormField(
                          items: c.breed,
                          value: c.selectedBreed.value,
                          hint: "Select breed",
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
                            value: "male",
                            groupVlaue: c.selectedGender.value,
                            onTap: c.changeGender,
                            title: "Male")),
                        Obx(() => SkyRadioButton(
                            value: "female",
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
                    c.ownerSignUp();
                    // Get.toNamed(OTPVerification.routeName);
                  },
                  title: "Next",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
