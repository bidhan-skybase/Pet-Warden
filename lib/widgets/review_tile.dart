import 'package:flutter/material.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/image_paths.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class ReviewTile extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? time;
  final int? stars;
  final String? description;
  const ReviewTile({
    this.imageUrl,
    this.name,
    this.time,
    this.stars,
    this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: PetWardenColors.lightGrey,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(17),
                    child: Image.asset(imageUrl ?? ImagePath.logo, fit: BoxFit.cover),
                  ),
                ),
                Text(
                  name ?? "",
                  style: CustomTextStyles.f13W400(color: PetWardenColors.textGrey),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 20,
                  width: 130,
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
                Text(
                  time ?? "",
                  style: CustomTextStyles.f10W400(color: PetWardenColors.textGrey),
                )
              ],
            ),
            Text(
              description ?? "",
              style: CustomTextStyles.f12W400(color: PetWardenColors.textColor),
            )
          ],
        ),
      ),
    );
  }
}
