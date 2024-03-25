
import 'package:flutter/material.dart';
import 'package:petwarden/main.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class SkyRadioButton extends StatelessWidget {
  final String value;
  final String title;
  final String groupVlaue;
  final Function(String value) onTap;
  const SkyRadioButton({
    super.key,
    required this.value,
    required this.groupVlaue,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(value);
      },
      child: Row(
        children: [
          Radio(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: PetWardenColors.primaryColor,
            value: value,
            fillColor:
            MaterialStateColor.resolveWith((states) => PetWardenColors.primaryColor),
            groupValue: groupVlaue,
            onChanged: (_) => onTap(value),
          ),
          Text(
            title,
            style: CustomTextStyles.f14W500(),
          )
        ],
      ),
    );
  }
}