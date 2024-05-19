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

  static Widget featuredList() {
    return Shimmer.fromColors(
        baseColor: PetWardenColors.shimmerBase,
        highlightColor: PetWardenColors.shimmerHighlight,
        child: SizedBox(
          height: 165,
          width: Get.width - 10,
          child: ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, builder) {
                return Column(
                  children: [
                    Container(
                      height: 150,
                      width: Get.width - 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: PetWardenColors.shimmerHighlight),
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                );
              }),
        ));
  }

  static Widget sitterBasicInfo() {
    return Shimmer.fromColors(
      baseColor: PetWardenColors.shimmerBase,
      highlightColor: PetWardenColors.shimmerHighlight,
      child: Column(
        children: [
          Container(
            height: 20,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: PetWardenColors.shimmerBase),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 20,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: PetWardenColors.shimmerBase),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: PetWardenColors.shimmerHighlight),
          ),
        ],
      ),
    );
  }

  static Widget review() {
    return Shimmer.fromColors(
      baseColor: PetWardenColors.shimmerBase,
      highlightColor: PetWardenColors.shimmerHighlight,
      child: Container(
        height: 80,
        width: Get.width - 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: PetWardenColors.shimmerHighlight),
      ),
    );
  }

  static Widget bio() {
    return Shimmer.fromColors(
      baseColor: PetWardenColors.shimmerBase,
      highlightColor: PetWardenColors.shimmerHighlight,
      child: ListView.separated(
          separatorBuilder: (c, b) {
            return const SizedBox(
              height: 4,
            );
          },
          itemCount: 4,
          shrinkWrap: true,
          itemBuilder: (context, builder) {
            return Container(
              height: 16,
              width: Get.width - 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: PetWardenColors.shimmerBase),
            );
          }),
    );
  }

  static Widget specializationShimmer() {
    return Shimmer.fromColors(
        baseColor: PetWardenColors.shimmerBase,
        highlightColor: PetWardenColors.shimmerHighlight,
        child: Wrap(
          spacing: 8,
          runSpacing: 11,
          children: [
            Container(
              width: 80,
              height: 35,
              decoration: BoxDecoration(
                  color: PetWardenColors.shimmerBase, borderRadius: BorderRadius.circular(4)),
            ),
            Container(
              width: 100,
              height: 35,
              decoration: BoxDecoration(
                  color: PetWardenColors.shimmerBase, borderRadius: BorderRadius.circular(4)),
            ),
            Container(
              width: 140,
              height: 35,
              decoration: BoxDecoration(
                  color: PetWardenColors.shimmerBase, borderRadius: BorderRadius.circular(4)),
            ),
            Container(
              width: 70,
              height: 35,
              decoration: BoxDecoration(
                  color: PetWardenColors.shimmerBase, borderRadius: BorderRadius.circular(4)),
            ),
            Container(
              width: 110,
              height: 35,
              decoration: BoxDecoration(
                  color: PetWardenColors.shimmerBase, borderRadius: BorderRadius.circular(4)),
            )
          ],
        ));
  }

  static Widget sitterInfo() {
    return Shimmer.fromColors(
      baseColor: PetWardenColors.shimmerBase,
      highlightColor: PetWardenColors.shimmerHighlight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Container(
                height: 12,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6), color: PetWardenColors.shimmerBase),
              ),
              const SizedBox(
                height: 7,
              ),
              Container(
                height: 16,
                width: 64,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: PetWardenColors.shimmerHighlight),
              )
            ],
          ),
          Column(
            children: [
              Container(
                height: 12,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6), color: PetWardenColors.shimmerBase),
              ),
              const SizedBox(
                height: 7,
              ),
              Container(
                height: 16,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: PetWardenColors.shimmerHighlight),
              )
            ],
          ),
          Column(
            children: [
              Container(
                height: 12,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6), color: PetWardenColors.shimmerBase),
              ),
              const SizedBox(
                height: 7,
              ),
              Container(
                height: 16,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: PetWardenColors.shimmerHighlight),
              )
            ],
          )
        ],
      ),
    );
  }
}
