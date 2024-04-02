import 'package:flutter/material.dart';
import 'package:petwarden/utils/constants/colors.dart';

import 'custom_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final String hint;
  final String? preIconPath;
  final bool? showSuffixIcon;
  final String? suffixIconPath;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Color? border;
  final Color? fillColor;
  final bool? readOnly;
  final bool? showError;
  final bool? autofocus;
  final String? labelText;
  final Function()? onTap;
  final Function(String)? onSubmitted;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;

  final int? maxCharacters;
  final TextCapitalization textCapitalization;
  final double borderRadius;
  final double height;
  final TextStyle? hintTextStyle;
  final int? maxLines;

  const CustomTextField({
    super.key,
    this.fillColor,
    required this.hint,
    this.preIconPath,
    this.suffixIconPath,
    this.showSuffixIcon,
    this.controller,
    this.validator,
    required this.textInputAction,
    required this.textInputType,
    this.border,
    this.readOnly = false,
    this.showError = true,
    this.textCapitalization = TextCapitalization.sentences,
    this.onTap,
    this.onFieldSubmitted,
    this.onSubmitted,
    this.autofocus = false,
    this.maxCharacters,
    this.focusNode,
    this.labelText,
    this.borderRadius = 8,
    this.height = 48.0,
    this.onChanged,
    this.maxLines,
    this.hintTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onTapOutside: (event) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },`
        // onChanged: onChanged,
        focusNode: focusNode,
        maxLength: maxCharacters,
        autofocus: autofocus!,
        textCapitalization: textCapitalization,
        onFieldSubmitted: onSubmitted,
        onTap: (onTap != null) ? onTap! : null,
        readOnly: (readOnly == null) ? false : readOnly!,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        maxLines: maxLines ?? 1,
        validator: (validator != null) ? validator : null,
        controller: (controller != null) ? controller : null,
        onChanged: (text) {
          if (onChanged != null) {
            onChanged!(text);
          }
        },
        style: const TextStyle(color: PetWardenColors.textColor, fontSize: 18),
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
          fillColor: fillColor ?? Colors.transparent,
          filled: fillColor != null,
          prefixIcon:
              (preIconPath != null) ? Image.asset(preIconPath!, fit: BoxFit.scaleDown) : null,
          // suffixIcon: showSuffixIcon != null && showSuffixIcon!
          suffixIcon: (suffixIconPath != null)
              ? GestureDetector(
                  onTap: () {}, child: Image.asset(suffixIconPath!, fit: BoxFit.scaleDown))
              : null,
          // : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(width: 2, color: border ?? PetWardenColors.borderColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(width: 2, color: border ?? PetWardenColors.errorColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide:
                BorderSide(width: 2, color: border ?? const Color(0xff123BA5).withOpacity(0.7)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(width: 2, color: border ?? PetWardenColors.errorColor),
          ),
          errorStyle: (showError!) ? const TextStyle(fontSize: 14) : const TextStyle(fontSize: 0),
          hintText: hint,
          hintStyle:
              hintTextStyle ?? CustomTextStyles.f14W500(color: PetWardenColors.highlightTextColor),
        ));
  }
}
