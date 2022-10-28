import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/sizes.dart';

class BookingDetailsWidget extends StatelessWidget {
  const BookingDetailsWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final String value;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children:  [
        Icon(icon),
        KSizedBox.kWidth_15,
         Text(
          title,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        const Spacer(),
         TextButton(
          onPressed: (){
            onTap();
          },
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: KColors.kBlueColor
              ),
          ),
         ) ,
      ],
    );
  }
}