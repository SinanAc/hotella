import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyType;
  const TextFieldWidget({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.keyType = TextInputType.emailAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        fillColor: KColors.kTextFieldColor,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(color: KColors.kGreyColor),
      ),
      keyboardType: keyType,
      style: const TextStyle(),
    );
  }
}