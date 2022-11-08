import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/navigations.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    Key? key,
    this.buttonColor = KColors.kThemeGreen,
    this.iconColor = KColors.kWhiteColor,
  }) : super(key: key);
  final Color buttonColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Navigations.pop,
      child: Card(
        color: buttonColor,
        margin: const EdgeInsets.only(left: 20, top: 15),
        child:  Padding(
          padding: const EdgeInsets.only(left: 12, top: 6, bottom: 6, right: 2),
          child: Icon(
            Icons.arrow_back_ios,
            color: iconColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}
