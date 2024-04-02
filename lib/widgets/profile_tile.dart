import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/icon_paths.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class ProfileTile extends StatelessWidget {
  final String iconUrl;
  final String title;
  final bool hasArrow;
  final VoidCallback? onTap;
  const ProfileTile({
    required this.iconUrl,
    required this.title,
    required this.hasArrow,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(iconUrl),
      title: Text(title,
          style: hasArrow
              ? CustomTextStyles.f16W400(color: Colors.black)
              : CustomTextStyles.f16W400(color: PetWardenColors.errorColor)),
      trailing: Visibility(visible: hasArrow, child: SvgPicture.asset(IconPath.rightArrow)),
    );
  }
}
