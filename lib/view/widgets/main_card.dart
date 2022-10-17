import 'package:flutter/material.dart';
import 'package:premio_inn/model/home/all_rooms_model/all_rooms.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/push_functions.dart';
import 'package:premio_inn/utils/strings.dart';
import 'package:premio_inn/view/screens/hotel/hotel_screen.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';

class MainCard extends StatelessWidget {
  const MainCard({
    Key? key,
    required this.hotel,
    required this.size,
  }) : super(key: key);
  final AllRoomssModel? hotel;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        PushFunctions.push(context, HotelScreen(hotel: hotel));
      },
      child: Container(
        height: size.height / 3.7,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(hotel?.images?.first[0].url??KStrings.dummyNetImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            children: [
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(123, 0, 0, 0),
                        borderRadius: BorderRadius.circular(8)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleWidget(
                          text: hotel?.property?.propertyName ??
                              'Hotel name is not available',
                          fontSize: 20,
                          color: KColors.kWhiteColor,
                        ),
                        TitleWidget(
                          text: hotel?.property?.landmark ?? '',
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(123, 0, 0, 0),
                        borderRadius: BorderRadius.circular(8)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: TitleWidget(
                      text: '₹ ${hotel?.price.toString()}',
                      fontSize: 18,
                      color: KColors.kWhiteColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
