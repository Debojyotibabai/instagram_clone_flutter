import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    required this.controller,
    required this.regExp,
  });

  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final RegExp regExp;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(7),
      ),
      borderSide: BorderSide(
        color: Theme.of(context).highlightColor,
        width: 3,
      ),
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(7),
      ),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.error,
        width: 3,
      ),
    );

    return TextFormField(
      controller: controller,
      cursorColor: Colors.lightBlueAccent,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 13,
          horizontal: 17,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 17,
        ),
        border: border,
        enabledBorder: border,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
          borderSide: BorderSide(
            color: Colors.lightBlueAccent,
            width: 3,
          ),
        ),
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
      ),
      style: const TextStyle(
        fontSize: 17,
        color: Colors.white,
      ),
      obscureText: isPassword,
      validator: (value) {
        if (value == "") {
          return "$hintText is required";
        } else if (!regExp.hasMatch(value!)) {
          return "Enter a valid ${hintText.toLowerCase()}";
        } else {
          return null;
        }
      },
    );
  }
}
