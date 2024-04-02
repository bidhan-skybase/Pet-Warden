import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/dash_pages/appointments_page_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/image_paths.dart';
import 'package:petwarden/widgets/chat_tile.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class ChatScreen extends StatelessWidget {
  final c = Get.find<AppointmentsPageController>();
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(children: [
              ListView.separated(
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
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const ChatTile(
                    imageUrl: ImagePath.profilePic,
                    name: "Drake",
                    message: "Hey there!. Thank you ",
                    time: "Today",
                  );
                },
              )
            ]),
          ),
        ));
  }
}
