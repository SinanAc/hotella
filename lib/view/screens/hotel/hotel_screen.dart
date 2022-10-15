import 'package:flutter/material.dart';
import 'package:premio_inn/model/home/all_rooms_model/all_rooms.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/screens/hotel/widgets/hotel_photos.dart';
import 'package:premio_inn/view/widgets/button_widget.dart';
import 'package:premio_inn/view/widgets/sub_title.dart';
import 'package:premio_inn/view_model/hotel_view_model.dart';
import 'package:provider/provider.dart';

class HotelScreen extends StatelessWidget {
  const HotelScreen({Key? key, required this.hotel}) : super(key: key);
  final AllRoomssModel? hotel;
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
              HotelPhotos(size: size,hotel: hotel),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleWidget(
                              text: '${hotel?.property?.propertyName}',
                              fontSize: 20,
                            ),
                            KSizedBox.kHeigh_5,
                            TitleWidget(
                              text: '${hotel?.property?.landmark}',
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
                    const TitleWidget(text: "Description", fontSize: 18),
                    KSizedBox.kHeigh_5,
                    TitleWidget(
                      text: '${hotel?.property?.propertyDetails}',
                      fontSize: 15,
                      color: Colors.grey.shade600,
                    ),
                    KSizedBox.kHeigh_10,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ButtonWidget(
            text: 'Add to cart ', onTap: () {}, color: KColors.kThemeGreen),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
