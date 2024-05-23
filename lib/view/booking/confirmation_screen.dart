import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/sitters/booking/confirm_appointment_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/icon_paths.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';
import 'package:petwarden/utils/validators.dart';
import 'package:petwarden/view/booking/payments_screen.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_network_image.dart';
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
                      height: 15,
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
                            c.start = selectedDateTime;
                            c.startingTime.value = c.formatDateTime(selectedDateTime);
                            if (c.endingTime.isNotEmpty) {
                              c.calculatePrice();
                            }
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
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime? dateTime = await showDatePicker(
                            context: Get.context!,
                            initialDate: c.start,
                            firstDate: c.start,
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
                            c.end = selectedDateTime;
                            c.endingTime.value = c.formatDateTime(selectedDateTime);
                            c.calculatePrice();
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
                      height: 15,
                    ),
                    Form(
                        key: c.formKey,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                            height: 15,
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
                            height: 15,
                          ),
                          CustomTextField(
                              hint: "Note",
                              controller: c.noteController,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.text),
                          const SizedBox(
                            height: 34,
                          ),
                          Text(
                            "Pet/s ",
                            style: CustomTextStyles.f16W600(),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 85,
                            width: Get.width,
                            child: ListView.builder(
                                itemCount: c.pets.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var pet = c.pets[index];
                                  return InkWell(
                                    onTap: () {
                                      c.petId.value = pet.id ?? "";
                                    },
                                    child: Obx(() => Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: pet.id == c.petId.value
                                                      ? PetWardenColors.primaryColor
                                                      : PetWardenColors.borderColor)),
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(100),
                                                child: SizedBox.fromSize(
                                                  size: const Size.fromRadius(26),
                                                  child: CustomNetworkImage(
                                                      imageUrl: pet.imageUrl ?? ""),
                                                ),
                                              ),
                                              Text(pet.name ?? "")
                                            ],
                                          ),
                                        )),
                                  );
                                }),
                          )
                        ]))
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 80,
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
                            Obx(() => SizedBox(
                                  width: Get.width / 3.5,
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    "Rs. ${c.total.toString()}",
                                    style: CustomTextStyles.f22W600(),
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                            width: 200,
                            child: CustomElevatedButton(
                                onPressed: () {
                                  if (c.startingTime.isEmpty || c.endingTime.isEmpty) {
                                    PetSnackBar.info(message: "Time slots can not be empty");
                                  } else if (c.start.isAfter(c.end)) {
                                    PetSnackBar.error(
                                        message: "End time should be after the start time.");
                                  } else if (c.formKey.currentState!.validate()) {
                                    c.onSubmit();
                                  }
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
