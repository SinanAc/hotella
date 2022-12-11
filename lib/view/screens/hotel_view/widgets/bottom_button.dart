import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/view/widgets/button_widget.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';

class BottomButtonWidget extends StatelessWidget {
  const BottomButtonWidget({
    Key? key,
    required this.price,
    required this.onTap,
  }) : super(key: key);
  final String price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 70,
        child: ColoredBox(
          color: KColors.kThemeBackground,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleWidget(
                      '₹$price',
                      fontSize: 20,
                    ),
                    TitleWidget(
                      'Total amount',
                      fontSize: 18,
                      color: Colors.grey.shade700,
                    ),
                  ],
                ),
                ButtonWidget(
                  text: 'Book now',
                  onTap: onTap,
                  width: MediaQuery.of(context).size.width / 2.5,
                  color: KColors.kThemeGreen,
                ),
              ],
            ),
          ),
        ),
      );
}
