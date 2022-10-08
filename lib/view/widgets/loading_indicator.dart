import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
    this.color =KColors.kThemeYellow
  }) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return  Center(
        child: CircularProgressIndicator(
            color: color));
  }
}