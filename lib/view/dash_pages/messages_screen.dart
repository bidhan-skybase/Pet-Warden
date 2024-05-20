import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/dash_pages/message_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/icon_paths.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_text_field.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class MessagesScreen extends StatelessWidget {
  var c = Get.find<MessageController>();
  static const routeName = "/messages-page";

  MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PetWardenColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: PetWardenColors.backgroundColor,
        elevation: 0,
        leading: InkResponse(
          radius: 20,
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 24,
            color: PetWardenColors.buttonColor,
          ),
        ),
        title: Text(
          c.reciverName,
          style: const TextStyle(color: PetWardenColors.buttonColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(child: _buildMessageList()),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hint: "Message",
                    controller: c.messageController,
                    textInputAction: TextInputAction.go,
                    textInputType: TextInputType.text,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (c.messageController.text.isNotEmpty) {
                      c.sendMessage();
                      c.getMessage();
                      c.chatRoomInfo();
                      c.messageController.clear();
                    }
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      // color: PetWardenColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: SvgPicture.asset(IconPath.sendIcon),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: c.getMessage(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final document = snapshot.data!.docs[index];
            return _buildMessageItem(document);
          },
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    final currentUser = c.user.value!.id.toString();
    final isCurrentUserSender = data['senderId'] == currentUser;
    final alignment = isCurrentUserSender ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: isCurrentUserSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisAlignment: isCurrentUserSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Visibility(
            visible: !isCurrentUserSender,
            child: Text(
              data['senderName'],
              style: CustomTextStyles.f10W600(color: PetWardenColors.highlightTextColor),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            constraints: BoxConstraints(maxWidth: Get.width / 2),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: PetWardenColors.primaryColor.withOpacity(0.8),
            ),
            child: Text(
              data["message"],
              style: CustomTextStyles.f15W400(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
