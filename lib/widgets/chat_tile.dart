import 'package:flutter/cupertino.dart';
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
  final bool isSender;
  const ChatTile({
    required this.imageUrl,
    required this.name,
    required this.message,
    required this.time,
    required this.isSender,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: SizedBox.fromSize(
              size: const Size.fromRadius(35),
              child: CustomNetworkImage(imageUrl: imageUrl),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width - 200,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  name,
                  style: CustomTextStyles.f20W600(color: PetWardenColors.textGrey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                        visible: isSender,
                        child: Text("You: ",
                            style: CustomTextStyles.f12W500(color: PetWardenColors.textGrey))),
                    SizedBox(
                      width: Get.width - 215,
                      child: Text(
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          message,
                          style: isSender
                              ? CustomTextStyles.f14W500(color: PetWardenColors.primaryColor)
                              : CustomTextStyles.f15W700(
                                  color: PetWardenColors.primaryColor,
                                )),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Expanded(
              child: SizedBox(
            width: 10,
          )),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: SizedBox(
              width: 50,
              child: Text(
                time,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: CustomTextStyles.f12W500(color: PetWardenColors.textGrey),
              ),
            ),
          )
        ],
      ),
    );
  }
}
