import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/icon_paths.dart';
import 'package:petwarden/utils/validators.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class CustomPasswordField extends StatelessWidget {
  final String hint;
  final String? preIconPath;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final bool eye;
  final VoidCallback onEyeClick;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final Function(String)? onSubmitted;
  final String? labelText;
  final double borderRadius;
  final double height;

  const CustomPasswordField({
    super.key,
    required this.hint,
    this.preIconPath,
    required this.eye,
    required this.onEyeClick,
    required this.controller,
    required this.textInputAction,
    this.validator,
    this.onSubmitted,
    this.focusNode,
    this.labelText,
    this.onChanged,
    required TextInputType textInputType,
    this.borderRadius = 8,
    this.height = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      focusNode: focusNode,
      onFieldSubmitted: onSubmitted,
      controller: controller,
      validator: validator ?? Validators.checkPasswordField,
      obscureText: eye,
      maxLines: 1,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
        label: labelText != null
            ? Text(
                labelText ?? "",
                style: CustomTextStyles.f18W400(
                  color: PetWardenColors.primaryColor,
                ),
              )
            : null,
        prefixIcon: (preIconPath != null) ? Image.asset(preIconPath!, fit: BoxFit.scaleDown) : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(width: 2, color: PetWardenColors.borderColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(width: 2, color: PetWardenColors.errorColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(width: 2, color: PetWardenColors.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(width: 2, color: PetWardenColors.errorColor),
        ),
        suffixIcon: IconButton(
          onPressed: onEyeClick,
          icon: (eye)
              ? SvgPicture.asset(
                  IconPath.eyeOff,
                  height: 24,
                  width: 24,
                  color: PetWardenColors.highlightTextColor,
                  fit: BoxFit.scaleDown,
                )
              : SvgPicture.asset(
                  IconPath.eye,
                  height: 24,
                  width: 24,
                  color: PetWardenColors.highlightTextColor,
                  fit: BoxFit.scaleDown,
                ),
        ),
        errorStyle: const TextStyle(fontSize: 14),
        hintText: hint,
        hintStyle: CustomTextStyles.f14W500(color: PetWardenColors.highlightTextColor),
      ),
      style: const TextStyle(color: PetWardenColors.textColor, fontSize: 18),
    );
  }
}
