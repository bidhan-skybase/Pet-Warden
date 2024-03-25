import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/dash_pages/appointments_page_controller.dart';
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
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            "Appointments",
            style: CustomTextStyles.f22W600(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Obx(() => Padding(
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
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: ListView.builder(
                    itemCount: 7,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, builder) {
                      return const AppointmentCard();
                    }),
              )
            ],
          ),
        ));
  }
}
