import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/chat_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/widgets/custom/custom_text_field.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class MessagesScreen extends StatefulWidget {
  static const routeName = "/messages-page";

  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  var c = Get.find<MessageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PetWardenColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: PetWardenColors.backgroundColor,
        elevation: 0,
        surfaceTintColor: PetWardenColors.backgroundColor,
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(child: _buildMesageList()),
            Row(
              children: [
                Expanded(
                    child: CustomTextField(
                        hint: "Message",
                        controller: c.messageController,
                        textInputAction: TextInputAction.go,
                        textInputType: TextInputType.text)),
                InkWell(
                  onTap: () async {
                    if (c.messageController.text.isNotEmpty) {
                      c.sendMessage("4", c.messageController.text);
                      c.messageController.clear();
                      c.getMessage("2", "4");
                      // await c.printMessages("2_4");
                    }
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: PetWardenColors.secondaryColor, shape: BoxShape.circle),
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                      Icons.arrow_upward,
                      color: PetWardenColors.textGrey,
                    ),
                  ),
                )
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

  Widget _buildMesageList() {
    return StreamBuilder(
        stream: c.getMessage(c.cc.currentUser.value!.id!.toString(), "4"),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading..');
          }
          return ListView(
            children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == c.cc.currentUser.value!.id!.toString()
        ? Alignment.centerRight
        : Alignment.centerLeft);
    return Container(
      alignment: alignment,
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: (data['senderId'] == c.cc.currentUser.value!.id!.toString()
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start),
        mainAxisAlignment: (data['sennderId'] == c.cc.currentUser.value!.id!.toString()
            ? MainAxisAlignment.end
            : MainAxisAlignment.start),
        children: [
          Text(
            data['senderEmail'],
            style: CustomTextStyles.f10W600(color: PetWardenColors.highlightTextColor),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: PetWardenColors.primaryColor.withOpacity(0.8)),
              child: Text(
                data["message"],
                style: CustomTextStyles.f15W400(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
