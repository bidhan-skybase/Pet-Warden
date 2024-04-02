import 'package:flutter/material.dart';
import 'package:petwarden/utils/constants/colors.dart';

import 'custom/custom_text_styles.dart';

class SitterSpecialization extends StatelessWidget {
  final String title;
  const SitterSpecialization({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(4), color: const Color(0xffE7E7E7)),
      padding: const EdgeInsets.all(9),
      child: Text(
        title,
        style: CustomTextStyles.f12W400(color: PetWardenColors.buttonColor),
      ),
    );
  }
}
