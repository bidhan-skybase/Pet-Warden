import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class SitterShimmer {
  static Widget sitterList() {
    return Shimmer.fromColors(
        baseColor: PetWardenColors.shimmerBase,
        highlightColor: PetWardenColors.shimmerHighlight,
        child: ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            itemBuilder: (context, builder) {
              return Column(
                children: [
                  Container(
                    height: 120,
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: PetWardenColors.shimmerHighlight),
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ],
              );
            }));
  }
}
