import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';

class DoubleColorTitle extends StatelessWidget {
  final String text1;
  final String text2;
  final Color firstColor;
  final double gap;
  final double textSize;
  const DoubleColorTitle({
    Key? key,
    required this.text1,
    required this.text2,
    this.firstColor = KColors.kThemeGreen,
    this.gap = 3,
    this.textSize = 22,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text1,
          style:  TextStyle(
            color: firstColor,
            fontSize: textSize,
            fontWeight: FontWeight.bold,
            fontFamily: 'SubMainFont',
            letterSpacing: 1,
          ),
        ),
        SizedBox(
          width: gap,
        ),
        Text(
          text2,
          style:  TextStyle(
            color: KColors.kThemeYellow,
            fontSize: textSize,
            fontWeight: FontWeight.bold,
            fontFamily: 'SubMainFont',
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
