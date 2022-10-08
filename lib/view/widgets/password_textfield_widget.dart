import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';

class PasswordTextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final dynamic signPro;
  const PasswordTextFieldWidget({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.validator,
    required this.controller,
    required this.signPro,
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
        suffixIcon: IconButton(
          onPressed: () {
            signPro.isObscure = !signPro.isObscure;
          },
          icon:
              Icon(signPro.isObscure ? Icons.visibility_off : Icons.visibility),
        ),
      ),
      obscureText: signPro.isObscure,
      style: const TextStyle(
        fontFamily: 'SubMainFont',
      ),
    );
  }
}
