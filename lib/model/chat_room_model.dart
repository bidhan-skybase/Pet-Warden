import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String chatRoomId;
  final String senderId;
  final String senderName;
  final String senderImage;
  final String receiverId;
  final String receiverName;
  final String receiverImage;
  final Timestamp timestamp;
  final String lastMessage;
  final List users;

  ChatRoom({
    required this.chatRoomId,
    required this.senderId,
    required this.senderName,
    required this.senderImage,
    required this.receiverId,
    required this.receiverName,
    required this.receiverImage,
    required this.timestamp,
    required this.lastMessage,
    required this.users,
  });
  Map<String, dynamic> toMap() {
    return {
      'chatRoomId': chatRoomId,
      'senderId': senderId,
      'senderName': senderName,
      'senderImage': senderImage,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'receiverImage': receiverImage,
      'timestamp': timestamp,
      'lastMessage': lastMessage,
      "users": users
    };
  }
}
