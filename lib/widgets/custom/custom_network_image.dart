import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:petwarden/utils/constants/image_paths.dart';
import 'package:petwarden/widgets/shimmers/image_shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit boxFit;
  final double? height;
  final double? width;
  final String errorImage;
  final Widget? placeHolder;
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.boxFit = BoxFit.cover,
    this.height,
    this.width,
    this.errorImage = ImagePath.placeHolder,
    this.placeHolder,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: boxFit,
      cacheKey: imageUrl,
      height: height,
      width: width,
      placeholder: (context, url) => placeHolder ?? const ImageShimmer(),
      errorWidget: (context, url, error) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox.fromSize(
              size: const Size.fromRadius(65),
              child: Image.asset(
                errorImage,
                fit: boxFit,
              ),
            )),
      ),
    );
  }
}
