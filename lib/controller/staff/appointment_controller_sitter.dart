import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:petwarden/model/appointment.dart';
import 'package:petwarden/repo/sitters_repo.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentControllerSitter extends GetxController {
  Rx todayDate = DateTime.now().obs;
  Rx selectedDate = DateTime.now().obs;
  Rx<CalendarFormat> format = CalendarFormat.month.obs;
  RxBool isOpened = false.obs;
  RxInt selectedAppointment = 0.obs;
  RxList<Appointment> appointments = <Appointment>[].obs;
  RxList<Appointment> filteredAppointments = <Appointment>[].obs;

  @override
  void onInit() {
    int currentMonth = DateTime.now().month;
    String currentMonthId = currentMonth.toString();
    getAppointments(currentMonthId);
    super.onInit();
  }

  getAppointments(String id) async {
    SittersRepo.getAppointments(
        monthId: id,
        onSuccess: (appointments) {
          this.appointments.value = appointments;
          filterAppointments(DateTime.now());
        },
        onError: (message) {
          PetSnackBar.error(message: message);
        });
  }

  void filterAppointments(DateTime date) {
    String targetDate = date.toIso8601String().substring(0, 10);
    print(targetDate);

    filteredAppointments.value = appointments.where((appointment) {
      String? appointmentDate = appointment.startDate;
      if (appointmentDate != null) {
        String formattedAppointmentDate =
            DateTime.parse(appointmentDate).toIso8601String().substring(0, 10);
        return formattedAppointmentDate == targetDate;
      }
      return false;
    }).toList();
  }

  String formatDateString(String dateString) {
    DateTime date = DateTime.tryParse(dateString) ?? DateTime.now();
    DateFormat formatter = DateFormat('EEEE, MMM d');
    return formatter.format(date);
  }

  String timeAgo(String dateString) {
    DateTime targetDate = DateTime.tryParse(dateString) ?? DateTime.now();
    Duration difference = targetDate.difference(DateTime.now());

    int days = difference.inDays;
    int hours = difference.inHours.abs() % 24;
    int minutes = difference.inMinutes.abs() % 60;

    if (difference.isNegative) {
      // Past dates
      if (days == -1 && hours == 0) {
        return "Yesterday";
      } else if (days < -1) {
        return "${-days} d $hours hr ago";
      } else if (days == 0 && hours > 0) {
        return "$hours hr $minutes min ago";
      } else if (days == 0 && hours == 0) {
        return "$minutes min ago";
      } else {
        return "${-days} d ago";
      }
    } else {
      // Future dates
      if (days == 1 && hours == 0) {
        return "Tmrw";
      } else if (days > 1) {
        return "in $days d $hours hrs";
      } else if (days == 0 && hours > 0) {
        return "in $hours hrs $minutes mins";
      } else if (days == 0 && hours == 0 && minutes > 0) {
        return "in $minutes mins";
      } else {
        return "Now";
      }
    }
  }
}
