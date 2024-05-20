import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/model/sitter_staff_model.dart';
import 'package:petwarden/model/user_model.dart';

class ChatScreenControllerSitter extends GetxController {
  var cc = Get.find<CoreController>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Rxn<SitterStaff> user = Rxn();

  @override
  void onInit() {
    user.value = cc.currentStaff.value;

    super.onInit();
  }

  Stream<QuerySnapshot> getChatRooms() {
    return firestore
        .collection("chat_rooms")
        .orderBy("timestamp", descending: true)
        .where("users", arrayContains: user.value!.id!.toString())
        .snapshots();
  }

  String formatTimestamp(Timestamp timestamp) {
    // Get the current time
    final now = DateTime.now();
    // Get the message timestamp as a DateTime object
    final messageTime = timestamp.toDate();

    // Calculate the difference between now and the message time
    final difference = now.difference(messageTime);

    // Format the difference into a human-readable string
    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} s';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} mins';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hrs';
    } else {
      final formatter = DateFormat('MMM d, yyyy');
      return formatter.format(messageTime);
    }
  }
}
