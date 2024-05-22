import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/sitters/booking/payment_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/image_paths.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';
import 'package:petwarden/view/booking/appointement_success.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class PaymentsPage extends StatelessWidget {
  static const routeName = "/payments-page";
  var c = Get.find<PaymentController>();
  PaymentsPage({super.key});

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
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Recommended",
                        style: CustomTextStyles.f16W500(
                          color: PetWardenColors.textColor,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        // c.payWithPayStack();
                        c.isSelected.toggle();
                      },
                      child: Obx(() => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
                            decoration: BoxDecoration(
                                boxShadow: c.isSelected.value
                                    ? [
                                        const BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0, 4),
                                          blurRadius: 2,
                                        ),
                                      ]
                                    : [],
                                border: Border.all(
                                    color: c.isSelected.value
                                        ? PetWardenColors.primaryColor
                                        : PetWardenColors.borderColor),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  ImagePath.paystack,
                                  height: 70,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "PET WARDEN",
                                      style:
                                          CustomTextStyles.f16W600(color: PetWardenColors.textGrey),
                                    ),
                                    Text(
                                        softWrap: true,
                                        "SUPPORTS - Card or \nBank Transfers",
                                        style: CustomTextStyles.f12W600(
                                          color: PetWardenColors.textGrey,
                                        ))
                                  ],
                                )
                              ],
                            ),
                          )),
                    )
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
                              "Rs. ${c.appointment.cost ?? "-"}",
                              style: CustomTextStyles.f22W600(),
                            )
                          ],
                        ),
                        SizedBox(
                            width: 200,
                            child: CustomElevatedButton(
                                onPressed: () {
                                  if (!c.isSelected.value) {
                                   PetSnackBar.info(
  message: "Please choose your preferred payment method to proceed. 💳",
);
                                  } else {
                                    c.payWithPayStack();
                                  }

                                  // Get.toNamed(AppointmentSuccess.routeName);
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
