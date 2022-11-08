import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';

class TextWidget extends Text {
  TextWidget(
    super.data, {
    Key? key,
    double size = 16,
    Color color = KColors.kBlackColor,
  }) : super(
          key: key,
          style: TextStyle(
            color: color,
            fontSize: size,
            wordSpacing: 1.5,
          ),
        );
}