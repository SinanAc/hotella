import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/widgets/main_title.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        color: KColors.kWhiteColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 45,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/images/user_icon.png'),
              ),
              KSizedBox.kWidth_20,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MainTitle(
                    text: 'Muhammad Sinan',
                    fontSize: 20,
                  ),
                  KSizedBox.kHeigh_5,
                  MainTitle(
                    text: '+91 9744875629',
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
