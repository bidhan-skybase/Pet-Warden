import 'package:flutter/material.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class ImageShimmer extends StatelessWidget {
  const ImageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: PetWardenColors.shimmerBase,
      highlightColor: PetWardenColors.shimmerHighlight,
      child: Container(
        color: PetWardenColors.shimmerBase,
      ),
    );
  }
}
