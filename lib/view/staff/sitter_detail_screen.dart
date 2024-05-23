import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petwarden/controller/staff/sitter_detail_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/helper/image_picker_helper.dart';
import 'package:petwarden/utils/validators.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_network_image.dart';
import 'package:petwarden/widgets/custom/custom_text_field.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';
import 'package:petwarden/widgets/pet_sitter_info.dart';
import 'package:petwarden/widgets/review_tile.dart';

class SitterDetailScreen extends StatelessWidget {
  static var routeName = "/sitterDetailScreen";
  final c = Get.find<SitterDetailController>();
  SitterDetailScreen({super.key});

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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: CustomElevatedButton(
            title: "Save Changes",
            onPressed: () {
              // c.onUpdate();
            }),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Form(
              key: c.sitterKey,
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
                                child: CustomNetworkImage(
                                  imageUrl: c.user.value?.profileImageUrl ?? "",
                                  height: 150,
                                  width: 150,
                                ),
                              )
                            : Visibility(
                                // visible: c.imageFileString.value.isNotEmpty,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.memory(
                                    base64Decode(c.profilePicPath.value),
                                    filterQuality: FilterQuality.high,
                                    height: 150,
                                    width: 150,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PetSitterInfo(
                        title: "Avg. ratings",
                        info: "${c.sitterInfo.value?.extraDetails?.avgRating ?? ""}",
                      ),
                      // PetSitterInfo(
                      //   title: "Pets",
                      //   info: c.sitterInfo.value?.s?.appointmentCount.toString(),
                      // ),
                      PetSitterInfo(
                        title: "Experience",
                        info: "${c.sitterInfo.value?.extraDetails?.experience ?? ""} year",
                      ),
                      PetSitterInfo(
                        title: "Ratings count",
                        info: "${c.reviews.length}",
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  CustomTextField(
                      hint: "Full name",
                      textCapitalization: TextCapitalization.words,
                      inputFormatter: [FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s]"))],
                      controller: c.nameController,
                      textInputAction: TextInputAction.next,
                      validator: Validators.checkFullName,
                      textInputType: TextInputType.text),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomTextField(
                      hint: "Email",
                      readOnly: true,
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
                  CustomTextField(
                      maxLines: 5,
                      hint: "Bio",
                      controller: c.biocontroller,
                      textInputAction: TextInputAction.next,
                      validator: Validators.checkFieldEmpty,
                      textInputType: TextInputType.text),
                  const SizedBox(
                    height: 25,
                  ),
                  ListView.builder(
                      itemCount: c.reviews.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 50),
                      itemBuilder: (context, index) {
                        var review = c.reviews[index];
                        return ReviewTile(
                          imageUrl: review.user?.profileImageUrl,
                          name: review.user?.name ?? "",
                          // name: review?.user?.name ?? "",
                          stars: review.rating,
                          time: "1 month ago",
                          description: review.comment ?? "",
                        );
                      })
                ],
              )),
        ),
      ),
    );
  }
}
