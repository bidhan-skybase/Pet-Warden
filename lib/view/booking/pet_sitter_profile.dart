import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/icon_paths.dart';
import 'package:petwarden/utils/constants/image_paths.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_text_field.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';
import 'package:petwarden/widgets/review_tile.dart';
import 'package:petwarden/widgets/sitter_specialization.dart';

import '../../widgets/pet_sitter_info.dart';

class PetSitterProfile extends StatelessWidget {
  static const routeName = "/petSitterProfile";
  const PetSitterProfile({super.key});

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
          child: Column(
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
                    "Joji Bhandari ".toUpperCase(),
                    style: CustomTextStyles.f16W600(color: PetWardenColors.primaryColor),
                  ),
                  Container(
                    height: 5,
                    width: 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100), color: const Color(0xff22EAB8)),
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
                  Text(
                    " Chitwan, Nepal",
                    style: CustomTextStyles.f14W600(color: PetWardenColors.textColor),
                  ),
                  const Text(
                    " | ",
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500, color: PetWardenColors.textGrey),
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
                  "Rs. 1200 /hr",
                  style: CustomTextStyles.f22W600(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PetSitterInfo(
                    title: "Pets",
                    info: "101",
                  ),
                  PetSitterInfo(
                    title: "Experience",
                    info: "1.5 year",
                  ),
                  PetSitterInfo(
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
                    CustomElevatedButton(onPressed: () {}, title: "Appoint"),
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
                      "Whether it's a midday stroll, a game of fetch, or simply some cuddle time on the couch, I'll tailor my services to match your pet's preferences and routine. With me by your side, you can enjoy peace of mind knowing that your furry companion is in capable hands, receiving the individuali... more",
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
                            stars: 5,
                            time: "1 month ago",
                            description: "Hello there",
                          );
                        }),
                    const SizedBox(
                      height: 8,
                    ),
                    const CustomTextField(
                        hint: "Write a review",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
