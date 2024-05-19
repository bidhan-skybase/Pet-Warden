import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/image_paths.dart';
import 'package:petwarden/widgets/custom/custom_network_image.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class PetSitterCard extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? address;
  final double? ratings;
  final bool? available;
  final VoidCallback? onTap;
  final int? stars;
  const PetSitterCard(
      {super.key,
      this.imageUrl,
      this.name,
      this.address,
      this.ratings,
      this.available,
      this.stars,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: PetWardenColors.lightGrey,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CustomNetworkImage(
                    height: 100,
                    width: 100,
                    imageUrl: imageUrl ?? "",
                  )),
              const SizedBox(
                width: 015,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width / 2.3,
                          child: Text(
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            name ?? "",
                            style: CustomTextStyles.f24W500(color: PetWardenColors.textGrey),
                          ),
                        ),
                        const Expanded(
                            child: SizedBox(
                          width: 10,
                        )),
                        Padding(
                          padding: const EdgeInsets.only(right: 3.0),
                          child: Text(
                            available == true ? "Available" : "Unavailable",
                            style: CustomTextStyles.f10W400(color: PetWardenColors.textGrey),
                          ),
                        ),
                        Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: available == true ? const Color(0xff22EAB8) : Colors.red),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          address ?? "",
                          style: CustomTextStyles.f12W500(color: PetWardenColors.textGrey),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 20,
                          // width: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: stars,
                            itemBuilder: (context, index) {
                              return const Icon(
                                Icons.star_rounded,
                                color: PetWardenColors.secondaryColor,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          // width: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 5 - stars!,
                            itemBuilder: (context, index) {
                              return Icon(
                                Icons.star_rounded,
                                color: PetWardenColors.textGrey.withOpacity(0.15),
                              );
                            },
                          ),
                        ),
                        // ItemBuilder(child: Icon(Icons.star_rounded, color: PetWardenColors.secondaryColor)),
                        const Expanded(
                            child: SizedBox(
                          width: 10,
                        )),
                        Text(
                          ratings.toString(),
                          style: const TextStyle(color: PetWardenColors.textGrey, fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
