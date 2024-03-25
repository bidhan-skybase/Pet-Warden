import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentsPageController extends GetxController {
  Rx todayDate = DateTime.now().obs;
  Rxn selectedDate = Rxn();
  Rx<CalendarFormat> format = CalendarFormat.month.obs;
}
