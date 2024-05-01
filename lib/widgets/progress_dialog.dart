import 'package:get/get.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ProgressDialog {
  SimpleFontelicoProgressDialog loading = SimpleFontelicoProgressDialog(
    context: Get.context!,
    barrierDimisable: false,
    // duration: Duration(
    //   milliseconds: 200
    // )
  );

  void show({String message = "Loading..."}) {
    // loading.show(s
    //   message: 'Loading...',
    //   type: SimpleFontelicoProgressDialogType.spinner,
    // );
    loading.show(
      message: message,
      type: GetPlatform.isAndroid
          ? SimpleFontelicoProgressDialogType.spinner
          : SimpleFontelicoProgressDialogType.iphone,
      indicatorColor: PetWardenColors.primaryColor,
      backgroundColor: PetWardenColors.backgroundColor,
    );
  }

  void hide() {
    loading.hide();
  }
}
