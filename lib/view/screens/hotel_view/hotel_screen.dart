import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:premio_inn/model/home/all_rooms_model/all_rooms.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/screens/hotel_view/widgets/amenities.dart';
import 'package:premio_inn/view/screens/hotel_view/widgets/booking_details.dart';
import 'package:premio_inn/view/screens/hotel_view/widgets/bottom_button.dart';
import 'package:premio_inn/view/screens/hotel_view/widgets/hotel_photos.dart';
import 'package:premio_inn/view/widgets/text_widget.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';
import 'package:premio_inn/view_model/hotel/hotel_view_model.dart';
import 'package:provider/provider.dart';

class HotelScreen extends StatelessWidget {
  const HotelScreen({Key? key, required this.hotel}) : super(key: key);
  final AllRoomsModel? hotel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final hotelPro = Provider.of<HotelViewModel>(context);
    return Scaffold(
      key: hotelPro.scaffoldKey,
      appBar: AppBar(toolbarHeight: 0, backgroundColor: KColors.kThemeGreen),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HotelPhotos(size: size, hotel: hotel),
              Padding(
                padding: const EdgeInsets.only(
                    left: 18.0, right: 18.0, top: 20.0, bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width / 1.6,
                              child: TitleWidget(
                                text: hotel?.property?.propertyName ??
                                    'Hotel name',
                                fontSize: 24,
                              ),
                            ),
                            KSizedBox.kHeigh_10,
                            SizedBox(
                              width: size.width / 1.6,
                              child: TextWidget(
                                  text: hotel?.property?.address ??
                                      'No address provided'),
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
                    KSizedBox.kHeigh_25,
                    const TitleWidget(
                        text: "Your booking details", fontSize: 20),
                    KSizedBox.kHeigh_10,
                    Card(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.black26,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12),
                        child: Column(children: [
                          BookingDetailsWidget(
                            icon: Icons.calendar_today_outlined,
                            title: 'Dates',
                            value:
                                '${DateFormat('EEE, MMM d').format(hotelPro.selectedDates.start)} - ${DateFormat('EEE, MMM d').format(hotelPro.selectedDates.end)}',
                            onTap: () {
                              hotelPro.selectDate(context,
                                  hotelPro.totalAmount(hotel?.price ?? 0));
                            },
                          ),
                          KSizedBox.kHeigh_5,
                          SizedBox(
                            width: size.width / 1.6,
                            child: const Divider(
                              thickness: 1.5,
                            ),
                          ),
                          KSizedBox.kHeigh_5,
                          BookingDetailsWidget(
                            icon: Icons.group_add_outlined,
                            title: 'Guests',
                            value:
                                '${hotelPro.rooms} Room, ${hotelPro.guests} Guests',
                            onTap: () {
                              hotelPro.selectRoomsAndGuests(
                                size.height/2.3
                              );
                            },
                          ),
                        ]),
                      ),
                    ),
                    KSizedBox.kHeigh_30,
                    const TitleWidget(text: "Amenities", fontSize: 20),
                    KSizedBox.kHeigh_15,
                    const AmenitiesWidget(icon: Icons.wifi, title: 'Free Wifi'),
                    KSizedBox.kHeigh_10,
                    const AmenitiesWidget(icon: Icons.tv, title: 'TV'),
                    KSizedBox.kHeigh_10,
                    const AmenitiesWidget(
                        icon: Icons.power_settings_new, title: 'Power backup'),
                    KSizedBox.kHeigh_30,
                    const TitleWidget(text: "House policies", fontSize: 20),
                    KSizedBox.kHeigh_15,
                    Row(
                      children: [
                        const Icon(Icons.vpn_key_outlined),
                        KSizedBox.kWidth_20,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextWidget(text: 'Check-in', size: 18),
                            KSizedBox.kHeigh_5,
                            TextWidget(
                              text: hotel?.checkinTime ?? '12PM',
                              size: 19,
                              color: Colors.grey.shade700,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextWidget(text: 'Checkout', size: 18),
                            KSizedBox.kHeigh_5,
                            TextWidget(
                              text: hotel?.checkinTime ?? '12PM',
                              size: 19,
                              color: Colors.grey.shade700,
                            ),
                          ],
                        ),
                        KSizedBox.kWidth_30,
                      ],
                    ),
                    KSizedBox.kHeigh_30,
                    const TitleWidget(text: "About", fontSize: 20),
                    KSizedBox.kHeigh_10,
                    TextWidget(
                        text: hotel?.property?.propertyDetails ??
                            'No description provided'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: BottomButtonWidget(
          price: '₹${hotelPro.totalAmount(hotel?.price ?? 0)}',
          onTap: (){
            //hotelPro.payment();
            hotelPro.onBookNow(hotel?.price??0);
          },
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
