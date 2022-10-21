import 'package:flutter/material.dart';
import 'package:premio_inn/model/home/all_rooms_model/all_rooms.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/widgets/back_button_widget.dart';
import 'package:premio_inn/view/widgets/main_card.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
    required this.categoryName,
    required this.roomsList,
    });
  final String categoryName;
  final List<AllRoomsModel> roomsList;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
             SizedBox(
            height: size.height / 5.8,
            width: size.width,
            child: const ColoredBox(
              color: KColors.kThemeGreen,
            ),
          ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                     children: [
                       BackButtonWidget(
                        buttonColor: Colors.grey.shade300,
                        iconColor: KColors.kThemeGreen,
                      ),
                      KSizedBox.kWidth_15,
                       TitleWidget(
                        text: categoryName,
                        fontSize: 24,
                        color: KColors.kThemeYellow,
                  ),
                     ],
                   ),
                   KSizedBox.kHeigh_5,
                  ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: roomsList.length,
                    itemBuilder: ((context, index) {
                      return MainCard(hotel: roomsList[index]);
                    }),
                    separatorBuilder: ((context, index) {
                      return KSizedBox.kHeigh_10;
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
