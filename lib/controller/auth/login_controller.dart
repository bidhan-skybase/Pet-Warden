

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/core_controller.dart';

class LoginController extends GetxController {

  var hidePass = true.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  // final FlutterSecureStorage storage = FlutterSecureStorage(); //To Store remember me username

  GlobalKey<FormState> signinKey = GlobalKey<FormState>();

  final CoreController coreController = Get.find();

  @override
  void onInit() {
    super.onInit();
    // loadRememberMe();
  }

  void onEyeClick() {
    hidePass.value = !hidePass.value;
  }







  // Future<void> onSubmit() async {
  //   if (signinKey.currentState!.validate()) {
  //     FocusManager.instance.primaryFocus?.unfocus();
  //     loading.show();
  //     await AuthRepo.signin(
  //         username: userNameController.text,
  //         password: passwordController.text,
  //         onSuccess: (user) {
  //           loading.hide();
  //           coreController.loadCurrentUser();
  //           SkySnackBar.success(
  //               title: "Signin Success",
  //               message: "User Signed in Successfully");
  //           Get.offAllNamed(DashScreen.routeName);
  //         },
  //         onError: (message) {
  //           SkySnackBar.error(title: "Signin Failed", message: message);
  //         });
  //   }else{
  //     rememberMe.value = false ;
  //   }
  // }
}