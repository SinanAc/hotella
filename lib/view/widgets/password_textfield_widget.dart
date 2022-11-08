import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';

class PasswordTextFieldWidget extends TextFormField {
  PasswordTextFieldWidget({
    Key? key,
    required String hintText,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    required dynamic signPro
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
        suffixIcon: IconButton(
          onPressed: () {
            signPro.isObscure = !signPro.isObscure;
          },
          icon:
              Icon(signPro.isObscure ? Icons.visibility_off : Icons.visibility),
        ),
      ),
      obscureText: signPro.isObscure,
        );
}

// class PasswordTextFieldWidget extends StatelessWidget {
//   final String hintText;
//   final TextEditingController controller;
//   final String? Function(String?)? validator;
//   final dynamic signPro;
//   const PasswordTextFieldWidget({
//     Key? key,
//     required this.hintText,
//     required this.validator,
//     required this.controller,
//     required this.signPro,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       validator: validator,
//       decoration: InputDecoration(
//         border: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(15.0)),
//         ),
//         fillColor: KColors.kTextFieldColor,
//         filled: true,
//         hintText: hintText,
//         hintStyle: const TextStyle(color: KColors.kGreyColor),
//         suffixIcon: IconButton(
//           onPressed: () {
//             signPro.isObscure = !signPro.isObscure;
//           },
//           icon:
//               Icon(signPro.isObscure ? Icons.visibility_off : Icons.visibility),
//         ),
//       ),
//       obscureText: signPro.isObscure,
//       style: const TextStyle(
//         fontFamily: 'SubMainFont',
//       ),
//     );
//   }
// }
