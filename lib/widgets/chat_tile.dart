import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/utils/constants/colors.dart';

import 'custom/custom_text_styles.dart';

class ChatTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String message;
  final String time;
  const ChatTile({
    required this.imageUrl,
    required this.name,
    required this.message,
    required this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox.fromSize(
              size: const Size.fromRadius(35),
              child: Image.asset(imageUrl, fit: BoxFit.cover),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: CustomTextStyles.f20W600(color: Colors.black),
            ),
            SizedBox(
              width: Get.width / 1.8,
              child: Text(
                message,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: CustomTextStyles.f16W500(color: PetWardenColors.textGrey),
              ),
            )
          ],
        ),
        Text(
          time,
          style: CustomTextStyles.f14W500(color: PetWardenColors.buttonColor),
        )
      ],
    );
  }
}
