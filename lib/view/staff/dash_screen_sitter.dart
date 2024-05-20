import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/staff/dash_screen_controller_sitter.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/icon_paths.dart';
import 'package:petwarden/view/dash_pages/profile_screen.dart';
import 'package:petwarden/view/error_screen.dart';
import 'package:petwarden/view/staff/appointments_screen_sitter.dart';
import 'package:petwarden/view/staff/chat_screen_sitter.dart';
import 'package:petwarden/view/staff/profile_screen_sitter.dart';

import '../../controller/core_controller.dart';

class DashScreenSitter extends StatelessWidget {
  static const String routeName = "/dashPageSitter/";
  DashScreenSitter({super.key});
  final dpc = Get.find<DashScreenControllerSitter>();
  final cc = Get.find<CoreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Obx(() => BottomAppBar(
            padding: EdgeInsets.zero,
            height: 60,
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: PetWardenColors.lightGrey,
              unselectedItemColor: PetWardenColors.textColor,
              selectedItemColor: PetWardenColors.buttonColor,
              unselectedFontSize: 12,
              selectedFontSize: 12,
              type: BottomNavigationBarType.fixed,
              currentIndex: dpc.currentIndex.value,
              onTap: dpc.onPageTapped,
              items: [
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(
                    IconPath.appointmentIconA,
                  ),
                  icon: SvgPicture.asset(
                    IconPath.appointmentIcon,
                  ),
                  label: "Appointments",
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(IconPath.chatIconA),
                  icon: SvgPicture.asset(IconPath.chatIcon),
                  label: "Chats",
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset(IconPath.profileIconA),
                  icon: SvgPicture.asset(IconPath.profileIcon),
                  label: "Profile",
                ),
              ],
            ),
          )),
      extendBody: true,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: dpc.pageController,
        children: const [
          AppointmentScreenSitter(),
          ChatScreenSitter(),
          ProfileScreenSitter(),
          ErrorScreen()
        ],
      ),
    );
  }
}
