// ignore_for_file: unused_import
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/dash_pages/appointments_page_controller.dart';
import 'package:petwarden/main.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/icon_paths.dart';
import 'package:petwarden/utils/constants/image_paths.dart';
import 'package:petwarden/view/dash_pages/timer_screen.dart';
import 'package:petwarden/widgets/appointment_card.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
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
                  child: Slidable(
                    key: const ValueKey(0),
                    endActionPane: ActionPane(
                      extentRatio: 0.3,
                      motion: const ScrollMotion(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 33),
                          child: SizedBox(
                            height: 220,
                            width: 100,
                            child: SlidableAction(
                              flex: 1,
                              onPressed: (value) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        "Confirm Delete",
                                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                      ),
                                      content: const Text(
                                        "Are you sure you want to cancel this appointment?",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      actions: <Widget>[
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomElevatedButton(
                                                buttonColor: PetWardenColors.backgroundColor,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                title: "Cancel",
                                                textStyle: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: PetWardenColors.textColor),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                              child: CustomElevatedButton(
                                                buttonColor: PetWardenColors.errorColor,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                title: "Cancel",
                                                textStyle: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              backgroundColor: PetWardenColors.errorColor,
                              foregroundColor: Colors.white,
                              label: "Delete",
                              icon: Icons.delete_outline,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                c.selectedDate.value.toString().substring(0, 10),
                                                style:
                                                    CustomTextStyles.f20W500(color: Colors.white),
                                              ),
                                              Text(
                                                "Pokhara, Nepal",
                                                style:
                                                    CustomTextStyles.f12W500(color: Colors.white),
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
                                                style:
                                                    CustomTextStyles.f14W500(color: Colors.white),
                                              ),
                                              Text(
                                                "5 days to go",
                                                style:
                                                    CustomTextStyles.f12W400(color: Colors.white),
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
                                // height: 150,
                                decoration: BoxDecoration(
                                  color: PetWardenColors.blueCardColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      dense: true,
                                      visualDensity:
                                          const VisualDensity(horizontal: -4, vertical: -4),
                                      minVerticalPadding: 0,
                                      contentPadding: const EdgeInsets.all(2),
                                      leading: const Icon(
                                        Icons.pets_outlined,
                                        color: PetWardenColors.secondaryColor,
                                      ),
                                      title: Text(
                                        "Appointed For: ",
                                        style: CustomTextStyles.f15W600(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        "Keanu",
                                        style: CustomTextStyles.f13W500(color: Colors.white),
                                      ),
                                    ),
                                    const Divider(
                                      color: PetWardenColors.borderColor,
                                    ),
                                    ListTile(
                                      dense: true,
                                      visualDensity:
                                          const VisualDensity(horizontal: -4, vertical: -4),
                                      minVerticalPadding: 0,
                                      contentPadding: const EdgeInsets.all(2),
                                      leading: const Icon(
                                        Icons.monetization_on_outlined,
                                        color: PetWardenColors.secondaryColor,
                                      ),
                                      title: Text(
                                        "Total Cost: ",
                                        style: CustomTextStyles.f15W600(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        "Rs. 1200",
                                        style: CustomTextStyles.f13W500(color: Colors.white),
                                      ),
                                    ),
                                    const Divider(
                                      color: PetWardenColors.borderColor,
                                    ),
                                    CustomElevatedButton(
                                        buttonColor: PetWardenColors.secondaryColor,
                                        textStyle: CustomTextStyles.f14W500(
                                            color: PetWardenColors.textColor),
                                        onPressed: () {
                                          Get.toNamed(TimerPage.routeName);
                                        },
                                        title: "Start Timer")
                                  ],
                                ),
                              ))
                        ]),
                  ),
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
