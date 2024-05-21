import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentControllerSitter extends GetxController {
  Rx todayDate = DateTime.now().obs;
  Rx selectedDate = DateTime.now().obs;
  Rx<CalendarFormat> format = CalendarFormat.month.obs;
  RxBool isOpened = false.obs;
  RxInt selectedAppointment = 0.obs;
}
