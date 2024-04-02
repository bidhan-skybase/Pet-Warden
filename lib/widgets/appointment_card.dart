import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petwarden/utils/constants/image_paths.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/icon_paths.dart';
import 'custom/custom_text_styles.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({super.key});

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        trailing: const SizedBox.shrink(),
        initiallyExpanded: _expanded,
        onExpansionChanged: (isExpanded) => setState(() => _expanded = isExpanded),
        title: Container(
          decoration: const BoxDecoration(
            color: PetWardenColors.blueCardColor,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(35),
                          child: Image.asset(ImagePath.profilePic, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Weekend",
                          style: CustomTextStyles.f20W500(color: Colors.white),
                        ),
                        Text(
                          "Pokhara, Nepal",
                          style: CustomTextStyles.f12W500(color: Colors.white),
                        ),
                      ],
                    ),
                    const Expanded(
                      child: SizedBox(
                        width: 10,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Status",
                          style: CustomTextStyles.f14W500(color: Colors.white),
                        ),
                        Text(
                          "5 days to go",
                          style: CustomTextStyles.f12W400(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox.fromSize(
                  size: const Size.fromHeight(12),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: PetWardenColors.secondaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        IconPath.appointmentIcon,
                        width: 17,
                      ),
                      Text(
                        "Wednesday, Jan 11",
                        style: CustomTextStyles.f12W500(),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        IconPath.clockIcon,
                        width: 17,
                      ),
                      Text(
                        "11:00 AM - 03:00 PM",
                        style: CustomTextStyles.f12W500(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: PetWardenColors.blueCardColor,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          )
          // Add your ad
          //Conditional details widgets here
          // Text(
          //   "This is an example of additional details that will be displayed when the card is expanded. You can add any relevant information here, such as appointment notes, doctor information, or pet details.",
          //   style: CustomTextStyles.f14W400(),
          // ),
        ],
      ),
    );
  }
}
