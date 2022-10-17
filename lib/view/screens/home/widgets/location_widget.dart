import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/view/widgets/text_widget.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: const [
        Icon(
          Icons.place,
          color: KColors.kWhiteColor,
          size: 22,
        ),
        SizedBox(width: 2),
        TextWidget(
          text: '507, BCK Kinfra, Calicut',
          color: Color.fromARGB(137, 255, 255, 255),
          size: 15,
          ),
      ],
    );
  }
}