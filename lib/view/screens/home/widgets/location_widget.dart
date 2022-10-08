import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';

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
        Text(
          '507, BCK Kinfra, Calicut',
          style: TextStyle(
              color: Color.fromARGB(137, 255, 255, 255),
              fontFamily: 'SubMainFont'),
        ),
      ],
    );
  }
}