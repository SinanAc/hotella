import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/screens/hotel/widgets/food_title.dart';
import 'package:premio_inn/view/widgets/button_widget.dart';
import 'package:premio_inn/view/widgets/main_title.dart';
import 'package:premio_inn/view_model/hotel_view_model.dart';
import 'package:provider/provider.dart';

class HotelScreen extends StatelessWidget {
  const HotelScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: KColors.kThemeBackground,
      appBar: AppBar(toolbarHeight: 0, backgroundColor: KColors.kThemeGreen),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HotelTitle(size: size),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MainTitle(
                              text: "KFC Restaurant",
                              fontSize: 20,
                            ),
                            KSizedBox.kHeigh_5,
                            MainTitle(
                              text: "Ramanattukara, Calicut",
                              fontSize: 18,
                              color: Colors.grey.shade700,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Consumer<HotelViewModel>(builder: (context, val, _) {
                          return IconButton(
                            icon: val.isFav ? val.favIcon : val.notFavIcon,
                            onPressed: () {
                              val.isFav = !val.isFav;
                            },
                          );
                        })
                      ],
                    ),
                    KSizedBox.kHeigh_10,
                    const MainTitle(text: "Description", fontSize: 18),
                    KSizedBox.kHeigh_5,
                    MainTitle(
                      text:
                          "KFC, a subsidiary of Yum! Brands, Inc. (NYSE: YUM.), is a global quick service restaurant brand with a rich, decades-long history of success and innovation. It all started with one cook, Colonel Harland Sanders, who created a finger lickin' good recipe more than 75 years ago, a list of secret herbs and spices scratched out on the back of the door to his kitchen. It all started with one cook, Colonel Harland Sanders, who created a finger lickin' good recipe more than 75 years ago, a list of secret herbs.",
                      fontSize: 17,
                      textAlign: TextAlign.left,
                      color: Colors.grey.shade600,
                    ),
                    KSizedBox.kHeigh_10,
                    ButtonWidget(
                        text: 'Add to cart ',
                        onTap: () {},
                        color: KColors.kThemeGreen)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
