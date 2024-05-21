import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petwarden/model/access_token_model.dart';
import 'package:petwarden/model/pet_model.dart';
import 'package:petwarden/model/sitter_staff_model.dart';
import 'package:petwarden/model/user_model.dart';
import 'package:petwarden/utils/constants/storage_keys.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';
import 'package:petwarden/utils/helper/storage-helper.dart';
import 'package:petwarden/view/auth/log_in_screen.dart';
import 'package:petwarden/view/splash_screen.dart';

enum USERTYPE { OWNER, STAFF }

class CoreController extends GetxController {
  Rxn<User> currentUser = Rxn();
  Rxn<SitterStaff> currentStaff = Rxn();
  RxList<Pet> pets = <Pet>[].obs;
  Rxn<AccessToken> accessToken = Rxn();
  USERTYPE userType = USERTYPE.OWNER;

  @override
  void onInit() async {
    if (getUserType() == USERTYPE.STAFF) {
      loadCurrentStaff(updateCurrentUser: true);
      loadCurrentUser(updateCurrentUser: true);
    } else {
      loadCurrentUser(updateCurrentUser: true);
      loadCurrentPet(updateCurrentPet: true);
    }

    super.onInit();
  }

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
    return currentUser.value != null || currentStaff.value != null;
  }

  USERTYPE getUserType() {
    if (StorageHelper.getUserType() == "OWNER") {
      return userType = USERTYPE.OWNER;
    } else if (StorageHelper.getUserType() == "SITTER") {
      return userType = USERTYPE.STAFF;
    } else {
      return userType;
    }
  }

  void logOut() async {
    final box = GetStorage();
    box.remove(StorageKeys.Owner);
    box.remove(StorageKeys.Token);
    box.remove(StorageKeys.Pet);
    box.remove(StorageKeys.UserType);
    box.remove(StorageKeys.Sitter);

    // Clear all values stored in current variables
    currentUser.value = null;
    currentStaff.value = null;
    pets.clear();
    accessToken.value = null;

    Get.offAllNamed(SplashScreen.routeName);
    PetSnackBar.success(title: "Success", message: "Logged out successfully.");
  }

  Future<void> loadCurrentUser({bool updateCurrentUser = false}) async {
    currentUser.value = StorageHelper.getOwner();
    print("this is the current user id ${currentUser.value?.id}");
  }

  Future<void> loadCurrentStaff({bool updateCurrentUser = false}) async {
    currentStaff.value = StorageHelper.getStaff();
    print("this is the current staff id ${currentStaff.value?.staff?.id}");
  }

  Future<void> loadCurrentPet({bool updateCurrentPet = false}) async {
    pets.value = StorageHelper.getPets()!;
  }
}
