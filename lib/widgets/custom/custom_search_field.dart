import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class CustomSearchField extends StatelessWidget {
  final Function(String)? onValueChange;
  final String hint;
  final String? prefixIconPath;
  final Widget? prefixIcon;
  final String? suffixIconPath;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Color? border;
  final bool? readOnly;
  final bool? showError;
  final bool? autofocus;
  final Function()? onTap;
  final Function(String)? onSubmitted;
  final TextCapitalization textCapitalization;
  final Color? fillColor;
  final bool showLable;
  final bool obscureText;
  final FocusNode? focusNode;
  final double borderRadius;
  final Function()? eyeClick;
  final int maxLine;

  const CustomSearchField({
    super.key,
    required this.hint,
    this.prefixIconPath,
    this.suffixIconPath,
    this.onValueChange,
    this.controller,
    this.validator,
    required this.textInputAction,
    required this.textInputType,
    this.border = const Color(0xffACACAC),
    this.readOnly = false,
    this.showError = true,
    this.textCapitalization = TextCapitalization.none,
    this.onTap,
    this.onSubmitted,
    this.autofocus = false,
    this.showLable = false,
    this.fillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.focusNode,
    this.borderRadius = 8,
    this.eyeClick,
    this.maxLine = 1,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          onTapOutside: (event) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          focusNode: focusNode,
          obscureText: obscureText,
          autofocus: autofocus!,
          textCapitalization: textCapitalization,
          onFieldSubmitted: onSubmitted,
          onTap: (onTap != null) ? onTap! : null,
          readOnly: (readOnly == null) ? false : readOnly!,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          maxLines: maxLine,
          validator: (validator != null) ? validator : null,
          controller: (controller != null) ? controller : null,
          onChanged: (text) {
            if (onValueChange != null) {
              onValueChange!(text);
            }
          },
          decoration: InputDecoration(
              label: showLable
                  ? Text(hint,
                      style: CustomTextStyles.f18W400(
                        color: PetWardenColors.primaryColor,
                      ))
                  : null,
              fillColor: fillColor ?? Colors.transparent,
              filled: true,
              prefixIconConstraints: const BoxConstraints(minWidth: 48),
              prefixIcon: (prefixIconPath != null)
                  ? SvgPicture.asset(
                      prefixIconPath!,
                      fit: BoxFit.scaleDown,
                      colorFilter:
                          const ColorFilter.mode(PetWardenColors.textColor, BlendMode.srcIn),
                    )
                  : prefixIcon,
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
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
              errorStyle:
                  (showError!) ? const TextStyle(fontSize: 12) : const TextStyle(fontSize: 0),
              hintText: hint,
              hintStyle: CustomTextStyles.f14W400(color: PetWardenColors.textGrey)),
          style: const TextStyle(color: PetWardenColors.textColor, fontSize: 18),
        )
      ],
    );
  }
}
