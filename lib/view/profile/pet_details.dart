import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class PetDetailScreen extends StatelessWidget {
  static var routeName = "/petDetailScreen";
  const PetDetailScreen({super.key});

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
          "Pet Details",
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
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
