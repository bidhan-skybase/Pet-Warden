import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petwarden/model/access_token_model.dart';
import 'package:petwarden/model/pet_model.dart';
import 'package:petwarden/model/user_model.dart';
import 'package:petwarden/utils/constants/storage_keys.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';
import 'package:petwarden/utils/helper/storage-helper.dart';
import 'package:petwarden/view/dash_pages/dash_screen.dart';

class CoreController extends GetxController {
  Rxn<User> currentUser = Rxn();
  Rxn<Pet> currentPet = Rxn();
  Rxn<AccessToken> accessToken = Rxn();

  Future<bool> checkCameraPermission() async {
    bool hasAccess = false;
    var status = await Permission.camera.status;
    hasAccess = status != PermissionStatus.denied && status != PermissionStatus.permanentlyDenied;
    if (hasAccess) {
      return hasAccess;
    }
    var permission = await Permission.storage.request();
    hasAccess =
        permission != PermissionStatus.denied && permission != PermissionStatus.permanentlyDenied;

    return hasAccess;
  }

  bool isOnboarded() {
    if (StorageHelper.getOnboarded() != null) {
      return true;
    } else {
      return false;
    }
  }

  bool isUserLoggedIn() {
    return currentUser.value != null;
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

  Future<void> loadCurrentUser({bool updateCurrentUser = false}) async {
    currentUser.value = StorageHelper.getOwner();
    // if (Get.isRegistered<ProfileController>()) {
    //   Get.find<ProfileController>().currentUser.value = currentUser.value;
    // }
    // if (updateCurrentUser) {
    //   updateUser();
    // }
  }

  Future<void> loadCurrentPet({bool updateCurrentPet = false}) async {
    currentPet.value = StorageHelper.getPet();
    // if (Get.isRegistered<ProfileController>()) {
    //   Get.find<ProfileController>().currentUser.value = currentUser.value;
    // }
    // if (updateCurrentUser) {
    //   updateUser();
    // }
  }
}
