import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/image_paths.dart';
import 'package:petwarden/view/booking/pet_sitter_profile.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class PetSitterCard extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? address;
  final String? ratings;
  final bool? available;
  final VoidCallback? onTap;
  const PetSitterCard(
      {super.key,
      this.imageUrl,
      this.name,
      this.address,
      this.ratings,
      this.available,
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
                  child: Image.asset(
                    imageUrl ?? ImagePath.logo,
                    height: 77,
                    width: 77,
                    fit: BoxFit.contain,
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
                        Text(
                          name ?? "",
                          style: CustomTextStyles.f24W500(color: PetWardenColors.textGrey),
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
                          width: 130,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return const Icon(
                                Icons.star_rounded,
                                color: PetWardenColors.secondaryColor,
                              );
                            },
                          ),
                        ),
                        // ItemBuilder(child: Icon(Icons.star_rounded, color: PetWardenColors.secondaryColor)),
                        Text(
                          ratings ?? "",
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
