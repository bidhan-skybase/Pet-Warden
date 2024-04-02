import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/icon_paths.dart';
import 'package:petwarden/utils/constants/image_paths.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';
import 'package:petwarden/widgets/profile_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(65),
                    child: Image.asset(ImagePath.profilePic, fit: BoxFit.cover),
                  ),
                ),
                Text(
                  "Hasbulla Magomedov",
                  style: CustomTextStyles.f20W600(),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "hasbulla@gmail.com",
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.f14W500(color: PetWardenColors.textGrey),
                ),
                const SizedBox(
                  height: 45,
                ),
                const ProfileTile(
                  iconUrl: IconPath.myDetailsIcon,
                  title: "My Details",
                  hasArrow: true,
                ),
                const ProfileTile(
                  iconUrl: IconPath.petDetailsIcon,
                  title: "Pet Profile",
                  hasArrow: true,
                ),
                const ProfileTile(
                  iconUrl: IconPath.passwordIcon,
                  title: "Change Password",
                  hasArrow: true,
                ),
                const ProfileTile(
                  iconUrl: IconPath.helpIcon,
                  title: "Get Help",
                  hasArrow: true,
                ),
                const ProfileTile(
                  iconUrl: IconPath.aboutUsIcon,
                  title: "About us",
                  hasArrow: true,
                ),
                const ProfileTile(
                  iconUrl: IconPath.deleteUserIcon,
                  title: "Delete Account",
                  hasArrow: false,
                ),
                const ProfileTile(
                  iconUrl: IconPath.logOutIcon,
                  title: "Log Out",
                  hasArrow: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
