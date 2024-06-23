// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:votingapp/core/extensions/app_theme_extensions.dart';
import 'package:votingapp/core/theme/colors.dart';

///
enum TextFieldType {
  ///
  name,

  ///
  text,

  ///
  email,

  ///
  phone,

  ///
  password,
}

///
class LabelTextFormField extends StatefulWidget {
  ///
  const LabelTextFormField({
    required this.label,
    required this.textEditingController,
    required this.inputType,
    required this.textFieldType,
    super.key,
    this.hintText,
    this.suffixIcon,
    this.obsecureText,
    this.enabled,
    this.isPassword = false,
    this.inputFormatters,
    this.prefix,
    this.validator,
    this.onChanged,
  });

  ///
  final String label;

  ///
  final Widget? suffixIcon;

  ///
  final String? hintText;

  ///
  final TextInputType inputType;

  ///
  final TextEditingController textEditingController;

  ///
  final TextFieldType textFieldType;

  ///
  final bool? obsecureText;

  ///
  final bool isPassword;

  ///
  final bool? enabled;

  ///
  final Widget? prefix;

  ///
  final List<TextInputFormatter>? inputFormatters;

  ///
  final String? Function(String?)? validator;

  ///
  final ValueChanged<String>? onChanged;

  @override
  State<LabelTextFormField> createState() => _LabelTextFormFieldState();
}

class _LabelTextFormFieldState extends State<LabelTextFormField> {
  bool isValidPassword(String value) {
    if (value.contains(' ') || value.contains('_')) {
      return false; // Password contains whitespace or underscore
    }

    return RegExp(
      r'^(?=.*[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*[!@#\$%^&*()-+=<>?/,.:;{}[\]|]).{8,}$',
    ).hasMatch(value);
  }

  bool isValidEmail(String value) {
    return RegExp(
      // r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      r'^(?!.*[@._-]{2})[a-zA-Z][\w.-]*@[a-zA-Z\d.-]+\.[a-zA-Z]{2,}$', //This will not accept special character and numbers in first letter.
    ).hasMatch(value);
  }

  bool isValidPhone(String value) {
    return RegExp(
      r'^[1-9][0-9]{6,14}$',
    ).hasMatch(value);
  }

  bool isValidName(String value) {
    return RegExp(
      r'^[a-zA-Z][a-zA-Z0-9\s]*$',
    ).hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: context.textTheme.titleLarge?.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: blackColor,
          ),
        ),
        const Gap(12),
        TextFormField(
          style: const TextStyle(color: midShadeColor),
          enabled: widget.enabled,
          controller: widget.textEditingController,
          obscureText: widget.obsecureText ?? false,
          inputFormatters: widget.inputFormatters ?? [],
          keyboardType: widget.inputType,
          validator: widget.validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Field should not be Empty.';
                } else if (widget.textFieldType == TextFieldType.email &&
                    value.contains(' ')) {
                  return "Email shouldn't contain white spaces.";
                } else if (widget.textFieldType == TextFieldType.email &&
                    !isValidEmail(value)) {
                  return 'Please enter valid Email.';
                } else if (widget.textFieldType == TextFieldType.password &&
                    !isValidPassword(value)) {
                  return 'The password must be at least 8 characters long\nwith at least a capital letter, a small letter, number,\nand a special character (excluding underscores)\nwith no white spaces.';
                } else if (widget.textFieldType == TextFieldType.password &&
                    value.contains('1Password*')) {
                  return 'Please enter separate Password.';
                } else if (widget.textFieldType == TextFieldType.phone &&
                    !isValidPhone(value)) {
                  return 'The phone number must be atleast 7 characters and \nshould not contain special characters';
                } else if (widget.textFieldType == TextFieldType.name &&
                    !isValidName(value)) {
                  return "The first letter shouldn't contain special characters\nand numbers.";
                }
                return null;
              },
          decoration: InputDecoration(
            prefixIcon: widget.prefix,
            hintText: widget.hintText,
            suffixIcon: widget.suffixIcon,
            hintStyle: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: lightShadeColor,
            ),
            filled: false,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
