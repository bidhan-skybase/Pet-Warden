import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/chat_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/view/dash_pages/messages_screen.dart';
import 'package:petwarden/widgets/chat_tile.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class ChatScreen extends StatelessWidget {
  final c = Get.find<MessageController>();
  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            "Messages",
            style: CustomTextStyles.f22W600(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            Expanded(child: _buildChatRooms()),
          ]),
        ));
  }

  Widget _buildChatRooms() {
    return StreamBuilder(
      stream: c.test(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading..');
        }
        return ListView.separated(
          separatorBuilder: (context, builder) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
                height: 1,
                width: Get.width,
                color: PetWardenColors.borderColor,
              ),
            );
          },
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
            var timeField = c.formatTimestamp(data["timestamp"]);
            return InkWell(
              radius: 24,
              onTap: () {
                // c.getID();
                Get.toNamed(MessagesScreen.routeName);
              },
              child: ChatTile(
                imageUrl: data['receiverImage'],
                name: data["receiverName"],
                message: data["lastMessage"],
                time: timeField,
              ),
            );
          },
        );
      },
    );
  }
}
