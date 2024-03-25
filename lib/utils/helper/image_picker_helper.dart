import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/core_controller.dart';


class ImageHelper {
  static final picker = ImagePicker();
  static final CoreController coreController = Get.find();

  static Future<void> pickImage({
    required ImageSource imageSource,
    required Function(List<XFile> pickedImages) onPickImages,
    Function(String message)? onError,
    VoidCallback? onCancel,
  }) async {
    var hasAccess = await coreController.checkCameraPermission();

    if (!hasAccess) {
      if (onError != null) {
        onError("Access Denied");
        return;
      }
    }

    List<XFile> pickedImages = [];
    if (imageSource == ImageSource.camera) {
      XFile? pickedImage = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        maxHeight: 400,
        maxWidth: 400
      );
      if (pickedImage != null) {
        pickedImages.add(pickedImage);
      }
    } else if (imageSource == ImageSource.gallery) {
      List<XFile>? galleryImages = await picker.pickMultiImage(
        imageQuality: 100,
          maxHeight: 400,
          maxWidth: 400
      );
      if (galleryImages != null) {
        pickedImages.addAll(galleryImages);
      }
    }

    if (pickedImages.isNotEmpty) {
      onPickImages(pickedImages);
    } else {
      if (onCancel != null) {
        onCancel();
      }
    }
  }
}