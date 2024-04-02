import 'package:flutter/material.dart';
import 'package:petwarden/utils/constants/colors.dart';

import 'custom/custom_text_styles.dart';

class PetSitterInfo extends StatelessWidget {
  final String? info;
  final String? title;
  const PetSitterInfo({
    this.info,
    this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          info ?? "-",
          style: CustomTextStyles.f14W700(color: PetWardenColors.primaryColor),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          title ?? "-",
          style: CustomTextStyles.f14W500(color: PetWardenColors.textGrey),
        )
      ],
    );
  }
}
