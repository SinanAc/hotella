import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';

class AccountGridItem extends StatelessWidget {
  const AccountGridItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: KColors.kWhiteColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 54,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: KColors.kWhiteColor,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 5.0,
                        spreadRadius: 1,
                        offset: const Offset(0, 6)),
                  ]),
              child: Icon(icon, color: KColors.kIconColor),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TitleWidget(title, fontSize: 20),
            )
          ],
        ),
      ),
    );
}
