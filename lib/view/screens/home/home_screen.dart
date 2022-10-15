import 'package:flutter/material.dart';
import 'package:premio_inn/model/home/all_rooms_model/all_rooms.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/screens/home/widgets/category_card.dart';
import 'package:premio_inn/view/screens/home/widgets/location_widget.dart';
import 'package:premio_inn/view/widgets/error_handler.dart';
import 'package:premio_inn/view/widgets/main_card.dart';
import 'package:premio_inn/view/screens/home/widgets/search_field.dart';
import 'package:premio_inn/view/widgets/double_color_title.dart';
import 'package:premio_inn/view_model/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final homeProvider = Provider.of<HomeViewModel>(context, listen: false);
    return FutureBuilder<List<AllRoomssModel>>(
      future: homeProvider.getAllRooms(context),
      builder:
          (BuildContext context, AsyncSnapshot<List<AllRoomssModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return ErrorHandleWidget(error: snapshot.error);
        } else if (snapshot.hasData) {
          if (snapshot.data == null) {
            return const Center(
              child: Text('No Data'),
            );
          } else {
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
                              onTap: () {},
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
                          itemCount: homeProvider.allRooms.length,
                          itemBuilder: ((context, index) {
                            return MainCard(
                              hotel: homeProvider.allRooms[index],
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
        } else if (snapshot.connectionState == ConnectionState.none) {
          return const Center(
            child: Text('Server is down, please try again Later'),
          );
        } else {
          return const Center(
            child: Text('Something Error'),
          );
        }
      },
    );
  }
}
