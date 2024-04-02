import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/controller/dash_page_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/icon_paths.dart';
import 'package:petwarden/view/dash_pages/appointments_screen.dart';
import 'package:petwarden/view/dash_pages/chat_screen.dart';
import 'package:petwarden/view/dash_pages/error_screen.dart';
import 'package:petwarden/view/dash_pages/home_screen.dart';
import 'package:petwarden/view/dash_pages/profile_screen.dart';

class DashPage extends StatelessWidget {
  static const String routeName = "/dashPage/";
  DashPage({super.key});
  final dpc = Get.find<DashPageController>();
  final cc = Get.find<CoreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Obx(
          () => BottomAppBar(
            // shape: const CircularNotchedRectangle(),
            // clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.zero,
            height: 60,
            // notchMargin: 4,
            // elevation: 0,
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
                  activeIcon: SvgPicture.asset(IconPath.homeIconA),
                  icon: SvgPicture.asset(IconPath.homeIcon),
                  label: "Home",
                ),
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
          ),
        ),
        extendBody: true,
        // body: Obx(
        //   () => dpc.pages[dpc.currentIndex.value],
        // ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: dpc.pageController,
          children: [
            HomeScreen(),
            AppointmentScreen(),
            ChatScreen(),
            const ProfileScreen(),
            const ErrorScreen()
          ],
        ));
  }
}
