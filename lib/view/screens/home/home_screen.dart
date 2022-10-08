import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/push_functions.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/screens/home/widgets/category_card.dart';
import 'package:premio_inn/view/screens/home/widgets/location_widget.dart';
import 'package:premio_inn/view/screens/hotel/hotel_screen.dart';
import 'package:premio_inn/view/widgets/main_card.dart';
import 'package:premio_inn/view/screens/home/widgets/search_field.dart';
import 'package:premio_inn/view/widgets/double_color_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Stack(
        children: [
          SizedBox(
            height: size.height / 2,
            width: size.width,
            child: const ColoredBox(
              color: KColors.kThemeGreen,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KSizedBox.kHeigh_5,
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: DoubleColorTitle(
                    text1: 'Hot',
                    text2: 'ella',
                    firstColor: KColors.kWhiteColor,
                    gap: 2,
                    textSize: 25,
                  ),
                ),
                KSizedBox.kHeigh_5,
                const LocationWidget(),
                KSizedBox.kHeigh_15,
                SearchField(size: size),
                KSizedBox.kHeigh_15,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryCard(
                      img: 'assets/images/hotel_icon.png',
                      title: 'Hotel',
                      onTap: () {
                        PushFunctions.push(context, const HotelScreen());
                      },
                    ),
                    CategoryCard(
                      img: 'assets/images/resort_icon.png',
                      title: 'Resort',
                      onTap: () {},
                    ),
                    CategoryCard(
                      img: 'assets/images/home_stay_icon.png',
                      title: 'Home Stay',
                      onTap: () {},
                    ),
                  ],
                ),
                KSizedBox.kHeigh_15,
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: ((context, index) {
                    return MainCard(
                      name: 'GK Royal palace',
                      loaction: 'Bangalore',
                      img: 'assets/images/hotel_dummy.jpg',
                      size: size,
                    );
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
    );
  }
}
