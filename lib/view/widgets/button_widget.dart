import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;
  final double width;
  const ButtonWidget({
    Key? key,
    required this.text,
    this.color = KColors.kThemeYellow,
    required this.onTap,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 13,
          ),
          elevation: 0,
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(
            color: KColors.kWhiteColor,
            fontSize: 16,
            fontFamily: 'SubMainFont',
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
