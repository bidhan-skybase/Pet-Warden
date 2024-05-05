import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/model/chat_room_model.dart';
import 'package:petwarden/model/message_model.dart';
import 'package:petwarden/model/user_model.dart';

class MessageController extends GetxController {
  var cc = Get.find<CoreController>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController messageController = TextEditingController();
  Rxn<User> user = Rxn();

  @override
  void onInit() {
    user.value = cc.currentUser.value;
    super.onInit();
  }

  Future<void> sendMessage(String receiverId, String receiverName, String message) async {
    final Timestamp timestamp = Timestamp.now();
    Message newMessage = Message(
        senderId: user.value!.id.toString(),
        senderName: user.value!.name!,
        receiverId: receiverId,
        receiverName: receiverName,
        message: message,
        timestamp: timestamp);

    List<String> ids = [user.value!.id!.toString(), receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");
    await firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessage(String userId, String receiverId) {
    List<String> ids = [userId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timeStamp", descending: false)
        .snapshots();
  }

  Future<void> chatRoomInfo(String chatRoomId) async {
    try {
      const receiverImage =
          "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
      final Timestamp timestamp = Timestamp.now();
      ChatRoom newRoom = ChatRoom(
          senderId: user.value!.id!.toString(),
          senderName: user.value!.name.toString(),
          senderImage: user.value!.profilePicture ?? "",
          receiverId: "4",
          receiverName: "sandeep",
          receiverImage: receiverImage,
          timestamp: timestamp);

      final roomInfoDocRef =
          firestore.collection('chat_rooms').doc(chatRoomId).collection('roomInfo').doc('info');
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

  Stream<QuerySnapshot> getRoomInfo() {
    String chatRoomId = "2_4";
    return firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("roomInfo")
        .orderBy("timestamp", descending: false)
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
