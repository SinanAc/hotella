import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/widgets/button_widget.dart';
import 'package:premio_inn/view/widgets/text_widget.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';
import 'package:premio_inn/view_model/hotel/hotel_view_model.dart';
import 'package:provider/provider.dart';

class RoomsAndGuestsBottomSheet extends StatelessWidget {
  const RoomsAndGuestsBottomSheet({Key? key,required this.amount}) : super(key: key);
  final int amount;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final hotelPro = Provider.of<HotelViewModel>(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 5),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const TitleWidget(
                    text: 'Select rooms & guests',
                    fontSize: 22,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      hotelPro.resetCountAndDate();
                      Navigations.pop();
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const TextWidget(text: 'Dates', size: 20),
                  TextButton(
                    onPressed: () {
                      hotelPro.selectDate(context, amount);
                    },
                    child: Text(
                      '${DateFormat('EEE, MMM d').format(hotelPro.selectedDates.start)} - ${DateFormat('EEE, MMM d').format(hotelPro.selectedDates.end)}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: KColors.kBlueColor),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const TextWidget(text: 'Rooms', size: 20),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            hotelPro.roomCountMinus();
                          },
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.black54,
                          ),
                        ),
                        KSizedBox.kWidth_15,
                        TextWidget(text: '${hotelPro.rooms}', size: 20),
                        KSizedBox.kWidth_15,
                        IconButton(
                          onPressed: () {
                            hotelPro.roomCountPlus();
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const TextWidget(text: 'Guests', size: 20),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            hotelPro.guestCountMinus();
                          },
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.black54,
                          ),
                        ),
                        KSizedBox.kWidth_15,
                        TextWidget(text: '${hotelPro.guests}', size: 20),
                        KSizedBox.kWidth_15,
                        IconButton(
                          onPressed: () {
                            hotelPro.guestCountPlus();
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonWidget(
                    text: 'Reset',
                    onTap: () {
                      hotelPro.resetCountAndDate();
                    },
                    color: KColors.kRedColor,
                    width: size.width / 2.3,
                  ),
                  ButtonWidget(
                    text: 'Confirm',
                    onTap: () {
                      Navigations.pop();
                    },
                    color: KColors.kThemeGreen,
                    width: size.width / 2.3,
                  ),
                ],
              ),
            ]),
      ),
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(top: 2.0),
        child: SizedBox(
          width: 40,
          child: Divider(
            thickness: 4,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
    );
  }
}
