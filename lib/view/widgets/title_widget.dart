import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';

class TitleWidget extends Text {
  TitleWidget(
    super.data, {
    Key? key,
    double fontSize = 16,
    Color color = KColors.kBlackColor,
  }) : super(
          key: key,
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            fontFamily: 'SubMainFont',
            wordSpacing: 1,
          ),
        );
}
