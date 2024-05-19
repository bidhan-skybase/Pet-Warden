import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petwarden/controller/profile/pet_owner_detail_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/helper/image_picker_helper.dart';
import 'package:petwarden/utils/validators.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_network_image.dart';
import 'package:petwarden/widgets/custom/custom_text_field.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class PetOwnerDetails extends StatelessWidget {
  static const routeName = "/petOwnerDetails";
  final c = Get.find<PetOwnerDetailController>();
  PetOwnerDetails({super.key});

  @override
  Widget build(BuildContext context) {
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
          "My Details",
          style: CustomTextStyles.f22W600(),
        ),
        // actions: [
        //   TextButton(
        //       onPressed: () {},
        //       child: Text(
        //         "Save",
        //         style: CustomTextStyles.f16W600(color: PetWardenColors.buttonColor),
        //       ))
        // ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: CustomElevatedButton(title: "Save Changes", onPressed: () {}),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Column(
            children: [
              Form(
                  key: c.ownerKey,
                  child: Column(
                    children: [
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
                                                  c.pickImage(
                                                    pickedImage,
                                                  );
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
                                                  c.pickImage(pickedImage);
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
                            Obx(() => c.profilePicPath.value == ""
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
                                      child: SizedBox.fromSize(
                                        size: const Size.fromRadius(65),
                                        child: CustomNetworkImage(
                                            imageUrl: c.owner.value?.profileImageUrl ?? ""),
                                        // child: Image.asset(ImagePath.profilePic, fit: BoxFit.cover),
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
                          hint: "Full name",
                          textCapitalization: TextCapitalization.words,
                          inputFormatter: [
                            FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s]"))
                          ],
                          controller: c.nameController,
                          textInputAction: TextInputAction.next,
                          validator: Validators.checkFullName,
                          textInputType: TextInputType.text),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomTextField(
                          hint: "Email",
                          controller: c.emailController,
                          textCapitalization: TextCapitalization.none,
                          textInputAction: TextInputAction.next,
                          validator: Validators.checkEmailField,
                          textInputType: TextInputType.text),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomTextField(
                          hint: "Phone number",
                          controller: c.phoneController,
                          textInputAction: TextInputAction.next,
                          validator: Validators.checkPhoneField,
                          textInputType: TextInputType.text),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
