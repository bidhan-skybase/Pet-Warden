import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/model/message_model.dart';

class MessageController extends ChangeNotifier {
  var cc = Get.find<CoreController>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController messageController = TextEditingController();

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = cc.currentUser.value!.id!.toString();
    final String currentUserEmail = cc.currentUser.value!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderId: "2",
        senderEmail: currentUserEmail,
        receiverId: "4",
        message: message,
        timestamp: timestamp);

    List<String> ids = [currentUserId, receiverId];
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

  Future<void> printMessages(String chatRoomId) async {
    try {
      // Reference to the collection of messages in the specified chat room
      CollectionReference messagesRef = FirebaseFirestore.instance
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages');

      // Listen to changes in the messages collection
      await messagesRef.get().then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          // Retrieve the message data from the document
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          // Print the message data
          print("Message ID: ${doc.id}");
          print("Sender ID: ${data['senderId']}");
          print("Sender Email: ${data['senderEmail']}");
          print("Receiver ID: ${data['receiverId']}");
          print("Message: ${data['message']}");
          // print("TimeStamp: ${data["timestamp"].toString()}");
          // Convert timestamp to DateTime if needed
          Timestamp timestamp = data['timeStamp'] as Timestamp;
          DateTime dateTime = timestamp.toDate();
          print("Timestamp: $dateTime");
          print("----");
        }
      });
    } catch (e) {
      print("Error printing messages: $e");
    }
  }
}
