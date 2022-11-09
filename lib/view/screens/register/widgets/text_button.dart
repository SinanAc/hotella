import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';

class TextButtonWidget extends StatelessWidget {
  final String text;
  final String buttonText;
  final Color color;
  final VoidCallback onTap;
  const TextButtonWidget({
    Key? key,
    this.text = '',
    this.color = KColors.kThemeYellow,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.white38,
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            buttonText,
            style:  TextStyle(
              color: color,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
