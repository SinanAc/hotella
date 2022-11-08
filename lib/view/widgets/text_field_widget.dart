import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';

class TextFieldWidget extends TextFormField {
  TextFieldWidget({
    Key? key,
    required String hintText,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    TextInputType keyType = TextInputType.emailAddress,
  }) : super(
          key: key,
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
        );
}