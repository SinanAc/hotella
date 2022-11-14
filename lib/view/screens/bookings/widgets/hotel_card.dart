import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/widgets/text_widget.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';

class OrderFoodCard extends StatelessWidget {
  const OrderFoodCard({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        color: KColors.kWhiteColor,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(imageUrl),
                backgroundColor: Colors.transparent,
              ),
              KSizedBox.kWidth_20,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleWidget(
                    'Chicken Burger',
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                  TextWidget('₹340', size: 16),
                  TextWidget('₹340', size: 16),
                ],
              ),
            ],
          ),
        ));
  }
}
