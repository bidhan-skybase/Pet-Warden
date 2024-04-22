import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/view/dash_pages/booking_complete_screen.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class TimerPage extends StatelessWidget {
  static const routeName = "/timerPage";
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: PetWardenColors.backgroundColor,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          "Timer",
          style: CustomTextStyles.f22W600(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TimerCountdown(
              timeTextStyle: CustomTextStyles.f24W600(),
              format: CountDownTimerFormat.hoursMinutesSeconds,
              endTime: DateTime.now().add(
                const Duration(
                  minutes: 0,
                  seconds: 5,
                ),
              ),
              onEnd: () {
                Get.toNamed(BookingCompleteScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
