// ignore_for_file: unused_import

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/dash_pages/appointments_page_controller.dart';
import 'package:petwarden/main.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/icon_paths.dart';
import 'package:petwarden/utils/constants/image_paths.dart';
import 'package:petwarden/widgets/appointment_card.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentScreen extends StatelessWidget {
  final c = Get.find<AppointmentsPageController>();
  AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Appointments",
          style: CustomTextStyles.f22W600(),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TableCalendar(
                    calendarStyle: CalendarStyle(
                        selectedDecoration: const BoxDecoration(
                            shape: BoxShape.circle, color: PetWardenColors.primaryColor),
                        todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: PetWardenColors.primaryColor.withOpacity(0.4))),
                    calendarFormat: c.format.value,
                    onFormatChanged: (format) {
                      c.format.value = format;
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      c.selectedDate.value = selectedDay;
                      c.todayDate.value = focusedDay;
                    },
                    selectedDayPredicate: (day) {
                      return isSameDay(c.selectedDate.value, day);
                    },
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: c.todayDate.value,
                  ),
                )),
          ])),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
            ),
          ),
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            automaticallyImplyLeading: false,
            leadingWidth: 0,
            toolbarHeight: 33,
            surfaceTintColor: PetWardenColors.backgroundColor,
            backgroundColor: Colors.white,
            flexibleSpace: Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: RichText(
                    text: TextSpan(
                      text: 'Appointment for ',
                      style: CustomTextStyles.f16W500(color: PetWardenColors.textColor),
                      children: <TextSpan>[
                        TextSpan(
                            text: c.selectedDate.value.toString().substring(0, 10),
                            style: CustomTextStyles.f14W600(color: PetWardenColors.buttonColor)),
                      ],
                    ),
                  ),
                )),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverList.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Accordion(
                      paddingListTop: 0,
                      disableScrolling: true,
                      headerBorderWidth: 2,
                      contentBorderWidth: 2,
                      scaleWhenAnimating: false,
                      headerBackgroundColor: PetWardenColors.blueCardColor,
                      headerBorderColor: PetWardenColors.blueCardColor,
                      headerBorderColorOpened: PetWardenColors.secondaryColor,
                      contentBackgroundColor: PetWardenColors.blueCardColor,
                      contentBorderColor: PetWardenColors.secondaryColor,
                      rightIcon: const SizedBox(),
                      children: [
                        AccordionSection(
                            header: Container(
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
                                              child: Image.asset(ImagePath.profilePic,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              c.selectedDate.value.toString().substring(0, 10),
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
                            content: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: PetWardenColors.blueCardColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ))
                      ]),
                );
              }),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
            ),
          ),
        ],
      ),
    );
  }
}
