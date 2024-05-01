import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petwarden/utils/constants/storage_keys.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';
import 'package:petwarden/utils/helper/storage-helper.dart';
import 'package:petwarden/view/dash_pages/dash_screen.dart';

class CoreController extends GetxController {
  RxBool isUserLoggedIn = true.obs;

  Future<bool> checkCameraPermission() async {
    bool hasAccess = false;
    var status = await Permission.camera.status;
    hasAccess = status != PermissionStatus.denied && status != PermissionStatus.permanentlyDenied;
    if (hasAccess) {
      return hasAccess;
    }
    var permission = await Permission.camera.request();
    hasAccess =
        permission != PermissionStatus.denied && permission != PermissionStatus.permanentlyDenied;

    return hasAccess;
  }

  bool isOnBoarded() {
    return StorageHelper.isOnboarded();
  }

  void logOut() async {
    final box = GetStorage();
    box.remove(StorageKeys.Owner);
    box.remove(StorageKeys.Token);
    box.remove(StorageKeys.UserType);
    box.remove(StorageKeys.Sitter);
    Get.offAllNamed(DashPage.routeName);
    // loadCustomer();
    PetSnackBar.success(title: "Success", message: "Logged out successfully.");
  }
}
