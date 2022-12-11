import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/widgets/button_widget.dart';
import 'package:premio_inn/view/widgets/text_widget.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';

Future<void> showPaymentOptions({
  required double width,
  required VoidCallback onPayAtHotelButton,
  required VoidCallback onPayNowButton,
  required int price,
}) async {
  await showDialog(
    context: Navigations.navigatorKey.currentContext!,
    builder: (_) => AlertDialog(
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(
              'Total amount to be paid',
            ),
            KSizedBox.kHeigh_5,
            TitleWidget(
              '₹$price',
            ),
            KSizedBox.kHeigh_20,
            ButtonWidget(
              text: 'Pay at hotel',
              width: width,
              onTap: onPayAtHotelButton,
            ),
            KSizedBox.kHeigh_15,
            ButtonWidget(
              text: 'Pay now',
              color: KColors.kThemeGreen,
              width: width,
              onTap: onPayNowButton,
            ),
          ],
        ),
      ),
    ),
  );
}
