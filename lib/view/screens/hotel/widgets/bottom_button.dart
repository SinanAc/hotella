import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/view/widgets/button_widget.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';

class BottomButtonWidget extends StatelessWidget {
  const BottomButtonWidget({
    Key? key,
    required this.price
    }) : super(key: key);
  final String price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                      text: price,
                      fontSize: 20,
                    ),
                    TitleWidget(
                      text: 'Total amount',
                      fontSize: 18,
                      color: Colors.grey.shade700,
                    ),
                  ],
                ),
                ButtonWidget(
                  text: 'Book now',
                  onTap: () {},
                  width: MediaQuery.of(context).size.width / 2.5,
                  color: KColors.kThemeGreen,
                )
              ],
            ),
          ),
        ),
      );
  }
}