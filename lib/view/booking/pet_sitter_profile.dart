import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/controller/sitters/pet_sitter_profile_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/icon_paths.dart';
import 'package:petwarden/utils/constants/image_paths.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';
import 'package:petwarden/view/auth/OTPverification_page.dart';
import 'package:petwarden/view/booking/confirmation_screen.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_text_field.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';
import 'package:petwarden/widgets/review_tile.dart';
import 'package:petwarden/widgets/sitter_specialization.dart';

import '../../widgets/pet_sitter_info.dart';

class PetSitterProfile extends StatelessWidget {
  static const routeName = "/petSitterProfile";
  final c = Get.find<PetSitterProfileController>();
  PetSitterProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 30,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 75),
                      child: Container(
                        width: Get.width,
                        height: Get.height * 0.2,
                        decoration: BoxDecoration(
                            color: PetWardenColors.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (() => Get.back()),
                            child: const CircleAvatar(
                                radius: 17,
                                backgroundColor: Color(0xffF6F4F4),
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 20,
                                  color: PetWardenColors.primaryColor,
                                )),
                          ),
                          const CircleAvatar(
                              radius: 17,
                              backgroundColor: Color(0xffF6F4F4),
                              child: Icon(
                                Icons.more_vert_rounded,
                                size: 20,
                                color: PetWardenColors.primaryColor,
                              ))
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: (Get.width - 150) / 2,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(70),
                            child: Image.asset(ImagePath.profilePic, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        c.sitter.value?.name?.toUpperCase() ?? "",
                        style: CustomTextStyles.f16W600(color: PetWardenColors.primaryColor),
                      ),
                      Container(
                        height: 5,
                        width: 5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff22EAB8)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(IconPath.locationIcon),
                      SizedBox(
                        width: 100,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          c.sitter.value?.address ?? "",
                          style: CustomTextStyles.f14W600(color: PetWardenColors.textColor),
                        ),
                      ),
                      const Text(
                        " | ",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: PetWardenColors.textGrey),
                      ),
                      Text(
                        "Pet Sitter",
                        style: CustomTextStyles.f14W600(color: PetWardenColors.textColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Center(
                    child: Text(
                      "Rs. ${c.sitter.value?.chargePerHour ?? ""} /hr",
                      style: CustomTextStyles.f22W600(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const PetSitterInfo(
                        title: "Pets",
                        info: "101",
                      ),
                      PetSitterInfo(
                        title: "Experience",
                        info: "${c.sitter.value?.experience ?? ""} year",
                      ),
                      const PetSitterInfo(
                        title: "Ratings",
                        info: "100",
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 41,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomElevatedButton(
                            onPressed: () {
                              var cc = Get.find<CoreController>();
                              if (cc.currentUser.value?.otpVerifiedAt != null) {
                                Get.toNamed(ConfirmationPage.routeName,
                                    arguments: {"sitter": c.sitter.value});
                              } else {
                                Get.toNamed(
                                  OTPVerification.routeName,
                                );
                              }
                            },
                            title: "Appoint"),
                        const SizedBox(
                          height: 39,
                        ),
                        Text(
                          "Abstract",
                          style: CustomTextStyles.f16W400(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Text(
                          c.sitter.value?.bio ?? "",
                          style: CustomTextStyles.f14W400(color: PetWardenColors.textGrey),
                        ),
                        const SizedBox(
                          height: 33,
                        ),
                        Text(
                          "Specialization",
                          style: CustomTextStyles.f16W400(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        const Wrap(
                          spacing: 8,
                          runSpacing: 11,
                          children: [
                            SitterSpecialization(
                              title: "Pet Sitting",
                            ),
                            SitterSpecialization(
                              title: "Dog Walking",
                            ),
                            SitterSpecialization(
                              title: "Special Needs Care",
                            ),
                            SitterSpecialization(
                              title: "Pet Boarding",
                            ),
                            SitterSpecialization(
                              title: "Pet Training",
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 33,
                        ),
                        Text(
                          "Reviews",
                          style: CustomTextStyles.f16W400(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        ListView.builder(
                            itemCount: 2,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, builder) {
                              return const ReviewTile(
                                imageUrl: ImagePath.profilePic,
                                name: "Anish Hirachan",
                                stars: 3,
                                time: "1 month ago",
                                description: "Hello there",
                              );
                            }),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextField(
                          hint: "Write a review",
                          textInputAction: TextInputAction.done,
                          readOnly: true,
                          textInputType: TextInputType.none,
                          onTap: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (builder) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context).viewInsets.bottom),
                                    child: Container(
                                      height: Get.height / 3,
                                      width: Get.width,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              topRight: Radius.circular(12))),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 10),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Add your review",
                                                style: CustomTextStyles.f20W600(),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              RatingBar.builder(
                                                initialRating: c.rating.value,
                                                direction: Axis.horizontal,
                                                minRating: 0,
                                                itemCount: 5,
                                                itemBuilder: (context, index) => const Icon(
                                                  Icons.star,
                                                  color: PetWardenColors.secondaryColor,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  if (c.rating.value == rating) {
                                                    c.rating.value = rating - 1;
                                                  } else {
                                                    c.rating.value = rating;
                                                  }
                                                },
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              CustomTextField(
                                                hint:
                                                    "What do you think about ${c.sitter.value?.name ?? ""}",
                                                textInputAction: TextInputAction.done,
                                                textInputType: TextInputType.text,
                                                controller: c.reviewController,
                                              ),
                                              const SizedBox(
                                                height: 22,
                                              ),
                                              CustomElevatedButton(
                                                  onPressed: () {
                                                    c.addRating();
                                                  },
                                                  title: "Add Review")
                                            ]),
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
