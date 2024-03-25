
import 'package:flutter/material.dart';
import 'package:petwarden/main.dart';
import 'package:petwarden/utils/constants/colors.dart';

class CustomDropdownFormField<T> extends StatelessWidget {
  final List<T>? items;
  final T? value;
  void Function(T?)? onChanged;
  final String Function(T)? displayText;
  final String? hintText;
  final InputDecoration? decoration;
  final UnderlineInputBorder? border;
  final String? hint;

  CustomDropdownFormField({
    super.key,
    this.items,
    this.value,
    this.onChanged,
    this.displayText,
    this.hintText,
    this.decoration,
    this.border,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(

      value: value,
      items: items?.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            displayText != null ? displayText!(item) : item.toString(),
            style: const TextStyle(
              color: PetWardenColors.textColor,
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? "Select an item" : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: decoration ??
          InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
                color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            border: border ??
                const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      width: 2,
                      color: PetWardenColors.borderColor,
                    )),
            errorBorder: border ??
                const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      width: 2,
                      color: PetWardenColors.errorColor,
                    )),
            enabledBorder: border ??
                const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      width: 2,
                      color: PetWardenColors.borderColor,
                    )),
            focusedBorder: border ??
                const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      width: 2,
                      color: PetWardenColors.primaryColor,
                    )),
            disabledBorder: border ??
                const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      width: 2,
                      color: PetWardenColors.borderColor,
                    )),
          ),
      style: const TextStyle(color: PetWardenColors.textColor, fontSize: 18),
    );
  }
}