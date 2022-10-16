import 'package:flutter/material.dart';
import 'package:premio_inn/model/home/all_rooms_model/all_rooms.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/strings.dart';
import 'package:premio_inn/view/widgets/back_button_widget.dart';
import 'package:premio_inn/view/widgets/page_indicator.dart';
import 'package:premio_inn/view_model/hotel/hotel_view_model.dart';
import 'package:provider/provider.dart';

class HotelPhotos extends StatelessWidget {
  const HotelPhotos({
    Key? key,
    required this.size,
    required this.hotel,
  }) : super(key: key);
  final Size size;
  final AllRoomssModel? hotel;

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelViewModel>(context, listen: false);
    return Stack(
      children: [
        SizedBox(
          height: size.height / 2.7,
          width: size.width,
        ),
        Positioned(
            top: 0,
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: PageView.builder(
              controller: hotelProvider.pController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(KStrings.dummyAssetImage))),
                  child: Image.network(
                    hotel?.images?.first[index].url ?? KStrings.dummyNetImage,
                    height: size.height / 2.7,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                );
              },
              itemCount: hotel?.images?.first.length ?? 1,
            )),
        const BackButtonWidget(
          buttonColor: KColors.kWhiteColor,
          iconColor: KColors.kThemeGreen,
        ),
        Positioned(
            bottom: 10.0,
            right: 150,
            left: 150,
          child: PageIndicatorWidget(
            controller: hotelProvider.pController,
            count: hotel?.images?.first.length ?? 1,
          ),
        )
      ],
    );
  }
}
