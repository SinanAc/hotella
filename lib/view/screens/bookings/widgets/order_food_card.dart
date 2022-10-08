import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/widgets/main_title.dart';

class OrderFoodCard extends StatelessWidget {
  const OrderFoodCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
        color: KColors.kWhiteColor,
        margin: const EdgeInsets.only(left: 10,right:10,bottom: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:12.0,horizontal:16),
          child: Row(
            children: [
               const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/mainBurger.png'),
                backgroundColor: Colors.transparent,
              ),
              KSizedBox.kWidth_20,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainTitle(
                    text: 'Chicken Burger',
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                  const MainTitle(text: '₹340', fontSize: 16),
                  const MainTitle(text: 'Arriving today', fontSize: 16,color: KColors.kLiteGreen),
                ],
              ),
            ],
          ),
        ));
  }
}