import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/model/chat_room_model.dart';
import 'package:petwarden/model/message_model.dart';
import 'package:petwarden/model/sitters_model.dart';
import 'package:petwarden/model/user_model.dart';

class MessageController extends GetxController {
  var cc = Get.find<CoreController>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController messageController = TextEditingController();
  Rxn<User> user = Rxn();
  String reciverId = "";
  String reciverName = "";

  @override
  void onInit() {
    user.value = cc.currentUser.value;
    var args = Get.arguments["reciverdetail"];
    if (args != null) {
      reciverId = args["id"];
      reciverName = args["name"];
    } else {
      Get.back();
    }
    super.onInit();
  }

  Future<void> sendMessage() async {
    final Timestamp timestamp = Timestamp.now();
    Message newMessage = Message(
        senderId: user.value!.id.toString(),
        senderName: user.value!.name!,
        receiverId: reciverId,
        receiverName: reciverName,
        message: messageController.text,
        timestamp: timestamp);

    List<String> ids = [user.value!.id!.toString(), reciverId];
    ids.sort();
    String chatRoomId = ids.join("_");
    await firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessage() {
    List<String> ids = [user.value!.id!.toString(), reciverId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timeStamp", descending: false)
        .snapshots();
  }

  Future<void> chatRoomInfo() async {
    try {
      var chatRoomId = "${user.value!.id!.toString()}_$reciverId";
      const receiverImage =
          "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
      final Timestamp timestamp = Timestamp.now();
      ChatRoom newRoom = ChatRoom(
          senderId: user.value!.id!.toString(),
          senderName: user.value!.name.toString(),
          senderImage: user.value!.profileImageUrl ?? "",
          receiverId: reciverId,
          receiverName: reciverName,
          receiverImage: receiverImage,
          timestamp: timestamp,
          lastMessage: messageController.text,
          users: [user.value!.id!.toString(), reciverId]);

      final roomInfoDocRef = firestore.collection('chat_rooms').doc(chatRoomId);
      final roomInfoDocSnapshot = await roomInfoDocRef.get();

      if (roomInfoDocSnapshot.exists) {
        await roomInfoDocRef.update(newRoom.toMap());
      } else {
        await roomInfoDocRef.set(newRoom.toMap());
      }
    } catch (error) {
      // Handle error
      print('Error updating chat room info: $error');
      rethrow;
    }
  }
}
