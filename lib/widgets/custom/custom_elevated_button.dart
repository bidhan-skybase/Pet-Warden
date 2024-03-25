import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petwarden/utils/constants/colors.dart';

import 'custom_text_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isDisabled;
  final bool isLoading;
  final bool? active;
  final String title;
  final String? suffixIconPath;
  final String? prefixIconPath;
  final double radius;
  final Color? buttonColor;
  final double height;
  final double? width;
  final TextStyle? textStyle;
  final Color? textColor;
  final ButtonStyle? style;
  final BorderSide? borderSide;
  final MainAxisAlignment? mainAlign;

  const CustomElevatedButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.suffixIconPath,
      this.prefixIconPath,
      this.radius = 8,
      this.buttonColor,
      this.isDisabled = false,
      this.height = 48,
      this.textStyle,
      this.width,
      this.style,
      this.textColor,
      this.isLoading = false,
      this.active,
      this.borderSide,
      this.mainAlign});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: style ??
            ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: buttonColor ?? PetWardenColors.buttonColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
              side: borderSide ?? BorderSide.none,
              // side: isDisabled
              //     ? BorderSide.none
              //     : const BorderSide(color: SkyColors.primaryColor, width: 1.5),
              minimumSize: width != null ? Size(width!, height) : Size.fromHeight(height),
            ),
        onPressed: (isDisabled)
            ? null
            : () {
                if (isLoading) return;
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                onPressed!();
              },
        child: Row(
          mainAxisAlignment: mainAlign ?? MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (prefixIconPath != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SvgPicture.asset(
                  prefixIconPath!,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
                : Text(
                    title,
                    style: textStyle ?? CustomTextStyles.f14W600(color: Colors.white),
                  ),
            if (suffixIconPath != null)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: SvgPicture.asset(
                  suffixIconPath!,
                  colorFilter: const ColorFilter.mode(Color(0xffC62717), BlendMode.srcIn),
                ),
              )
          ],
        ));
  }
}
