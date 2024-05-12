import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:petwarden/controller/sitters/booking/confirm_appointment_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/icon_paths.dart';
import 'package:petwarden/utils/validators.dart';
import 'package:petwarden/view/booking/payments_screen.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_text_field.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class ConfirmationPage extends StatelessWidget {
  static const routeName = "/confirmationPage";
  final c = Get.find<ConfirmAppointmentController>();
  ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          "Confirm Appointment",
          style: CustomTextStyles.f22W600(),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height - Get.statusBarHeight,
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 34,
                    ),
                    Text(
                      "Time Slot *",
                      style: CustomTextStyles.f16W600(),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime? dateTime = await showDatePicker(
                            context: Get.context!,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 180)));

                        if (dateTime != null) {
                          TimeOfDay? time = await showTimePicker(
                            initialEntryMode: TimePickerEntryMode.input,
                            context: Get.context!,
                            initialTime: TimeOfDay.now(),
                          );

                          if (time != null) {
                            DateTime selectedDateTime = DateTime(
                              dateTime.year,
                              dateTime.month,
                              dateTime.day,
                              time.hour,
                              time.minute,
                            );
                            c.startingTime.value = c.formatDateTime(selectedDateTime);
                          }
                        }
                      },
                      child: Container(
                        height: 48,
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: PetWardenColors.borderColor, width: 2)),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "From",
                                style: CustomTextStyles.f14W500(color: PetWardenColors.textGrey),
                              ),
                            ),
                            Obx(() => Text(c.startingTime.value,
                                style: CustomTextStyles.f14W500(
                                  color: PetWardenColors.textGrey,
                                ))),
                            SvgPicture.asset(
                              IconPath.rightArrow,
                              height: 13,
                              colorFilter:
                                  const ColorFilter.mode(PetWardenColors.textGrey, BlendMode.srcIn),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime? dateTime = await showDatePicker(
                            context: Get.context!,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 180)));

                        if (dateTime != null) {
                          TimeOfDay? time = await showTimePicker(
                            initialEntryMode: TimePickerEntryMode.input,
                            context: Get.context!,
                            initialTime: TimeOfDay.now(),
                          );

                          if (time != null) {
                            DateTime selectedDateTime = DateTime(
                              dateTime.year,
                              dateTime.month,
                              dateTime.day,
                              time.hour,
                              time.minute,
                            );
                            c.endingTime.value = c.formatDateTime(selectedDateTime);
                          }
                        }
                      },
                      child: Container(
                        height: 48,
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: PetWardenColors.borderColor, width: 2)),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "To",
                                style: CustomTextStyles.f14W500(color: PetWardenColors.textGrey),
                              ),
                            ),
                            Obx(() => Text(c.endingTime.value,
                                style: CustomTextStyles.f14W500(
                                  color: PetWardenColors.textGrey,
                                ))),
                            SvgPicture.asset(
                              IconPath.rightArrow,
                              height: 13,
                              colorFilter:
                                  const ColorFilter.mode(PetWardenColors.textGrey, BlendMode.srcIn),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 34,
                    ),
                    Text(
                      "Address *",
                      style: CustomTextStyles.f16W600(),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    CustomTextField(
                        validator: Validators.checkFieldEmpty,
                        hint: "Address",
                        controller: c.addressController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text),
                    const SizedBox(
                      height: 34,
                    ),
                    Text(
                      "Emergency Contact Number *",
                      style: CustomTextStyles.f16W600(),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    CustomTextField(
                        validator: Validators.checkPhoneField,
                        hint: "Phone number",
                        controller: c.contactController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text),
                    const SizedBox(
                      height: 34,
                    ),
                    Text(
                      "Note ",
                      style: CustomTextStyles.f16W600(),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    CustomTextField(
                        hint: "Note",
                        controller: c.noteController,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text)
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 100,
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    color: PetWardenColors.lightGrey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Total",
                              style: CustomTextStyles.f18W500(color: PetWardenColors.primaryColor),
                            ),
                            Text(
                              "Rs. 3000",
                              style: CustomTextStyles.f22W600(),
                            )
                          ],
                        ),
                        SizedBox(
                            width: 200,
                            child: CustomElevatedButton(
                                onPressed: () {
                                  Get.toNamed(PaymentsPage.routeName);
                                },
                                title: "Continue"))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
