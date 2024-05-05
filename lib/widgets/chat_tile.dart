import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/widgets/custom/custom_network_image.dart';

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
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox.fromSize(
            size: const Size.fromRadius(35),
            child: CustomNetworkImage(imageUrl: imageUrl),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          name,
          style: CustomTextStyles.f20W600(color: PetWardenColors.textGrey),
        ),
        const Expanded(
            child: SizedBox(
          width: 10,
        )),
        SizedBox(
          width: 50,
          child: Text(
            time,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: CustomTextStyles.f12W500(color: PetWardenColors.buttonColor),
          ),
        )
      ],
    );
  }
}
