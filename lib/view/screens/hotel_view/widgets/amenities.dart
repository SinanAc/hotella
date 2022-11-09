import 'package:flutter/material.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/widgets/text_widget.dart';

class AmenitiesWidget extends StatelessWidget {
  const AmenitiesWidget({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        KSizedBox.kWidth_15,
        TextWidget(title),
      ],
    );
  }
}
