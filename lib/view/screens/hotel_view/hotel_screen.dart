import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:premio_inn/model/home/all_rooms.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/screens/hotel_view/widgets/amenities.dart';
import 'package:premio_inn/view/screens/hotel_view/widgets/booking_details.dart';
import 'package:premio_inn/view/screens/hotel_view/widgets/bottom_button.dart';
import 'package:premio_inn/view/screens/hotel_view/widgets/hotel_photos.dart';
import 'package:premio_inn/view/widgets/loading_indicator.dart';
import 'package:premio_inn/view/widgets/text_widget.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';
import 'package:premio_inn/view_model/hotel/booking_.dart';
import 'package:premio_inn/view_model/hotel/hotel_view_model.dart';
import 'package:provider/provider.dart';

class HotelScreen extends StatelessWidget {
  const HotelScreen({Key? key, required this.hotel}) : super(key: key);
  final AllRoomsModel hotel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final hotelPro = context.read<HotelViewModel>();
    final bookingPro = context.read<BookingViewModel>();
    bookingPro.initializeRazorPay();
    return Stack(
      children: [
        Scaffold(
          key: hotelPro.scaffoldKey,
          appBar:
              AppBar(toolbarHeight: 0, backgroundColor: KColors.kThemeGreen),
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
                                    hotel.property?.propertyName ??
                                        'Hotel name',
                                    fontSize: 24,
                                  ),
                                ),
                                KSizedBox.kHeigh_10,
                                SizedBox(
                                  width: size.width / 1.6,
                                  child: TextWidget(hotel.property?.address ??
                                      'No address provided'),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Selector<HotelViewModel, bool>(
                              selector: (_, provider) => provider.isFav,
                              builder: (_, isFav, __) {
                                return IconButton(
                                  icon: isFav
                                      ? hotelPro.favIcon
                                      : hotelPro.notFavIcon,
                                  onPressed: () {
                                    hotelPro.isFav = !hotelPro.isFav;
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        KSizedBox.kHeigh_25,
                        TitleWidget("Your booking details", fontSize: 20),
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
                              Selector<HotelViewModel, DateTimeRange>(
                                selector: (_, provider) =>
                                    provider.selectedDates,
                                builder: (_, dateRange, __) {
                                  return BookingDetailsWidget(
                                    icon: Icons.calendar_today_outlined,
                                    title: 'Dates',
                                    value:
                                        '${DateFormat('EEE, MMM d').format(dateRange.start)} - ${DateFormat('EEE, MMM d').format(dateRange.end)}',
                                    onTap: () {
                                      hotelPro.selectRoomsAndGuests(
                                        size.height / 1.9,
                                        hotel.price ?? 0,
                                        hotel,
                                      );
                                    },
                                  );
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
                              Consumer<HotelViewModel>(builder: (_, value, __) {
                                return BookingDetailsWidget(
                                  icon: Icons.group_add_outlined,
                                  title: 'Guests',
                                  value:
                                      '${value.rooms} Room, ${value.guests} Guests',
                                  onTap: () {
                                    hotelPro.selectRoomsAndGuests(
                                      size.height / 1.9,
                                      hotel.price ?? 0,
                                      hotel,
                                    );
                                  },
                                );
                              }),
                            ]),
                          ),
                        ),
                        KSizedBox.kHeigh_30,
                        TitleWidget("Amenities", fontSize: 20),
                        KSizedBox.kHeigh_15,
                        const AmenitiesWidget(
                            icon: Icons.wifi, title: 'Free Wifi'),
                        KSizedBox.kHeigh_10,
                        const AmenitiesWidget(icon: Icons.tv, title: 'TV'),
                        KSizedBox.kHeigh_10,
                        const AmenitiesWidget(
                            icon: Icons.power_settings_new,
                            title: 'Power backup'),
                        KSizedBox.kHeigh_30,
                        TitleWidget("House policies", fontSize: 20),
                        KSizedBox.kHeigh_15,
                        Row(
                          children: [
                            const Icon(Icons.vpn_key_outlined),
                            KSizedBox.kWidth_20,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget('Check-in', size: 18),
                                KSizedBox.kHeigh_5,
                                TextWidget(
                                  hotel.checkinTime ?? '12PM',
                                  size: 19,
                                  color: Colors.grey.shade700,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget('Checkout', size: 18),
                                KSizedBox.kHeigh_5,
                                TextWidget(
                                  hotel.checkinTime ?? '12PM',
                                  size: 19,
                                  color: Colors.grey.shade700,
                                ),
                              ],
                            ),
                            KSizedBox.kWidth_30,
                          ],
                        ),
                        KSizedBox.kHeigh_30,
                        TitleWidget("About", fontSize: 20),
                        KSizedBox.kHeigh_10,
                        TextWidget(hotel.property?.propertyDetails ??
                            'No description provided'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Selector<HotelViewModel, int>(
              selector: (_, provider) => provider.totalAmount(hotel.price ?? 0),
              builder: (_, totalPrice, __) {
                return BottomButtonWidget(
                  price: '$totalPrice',
                  onTap: () async {
                    bookingPro.onBookNowButton(hotel, size.width / 2);
                  },
                );
              }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
        Selector<BookingViewModel, bool>(
          selector: (_, provider) => provider.isLoading,
          builder: (_, isLoading, __) {
            return isLoading
                ? const Opacity(
                    opacity: 0.7,
                    child:
                        ModalBarrier(dismissible: false, color: Colors.black),
                  )
                : const SizedBox();
          },
        ),
        Selector<BookingViewModel, bool>(
          selector: (_, provider) => provider.isLoading,
          builder: (_, isLoading, __) {
            return isLoading
                ? Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const LoadingIndicator(),
                        KSizedBox.kHeigh_15,
                        TextWidget('Please wait...', color: Colors.white)
                      ],
                    ),
                  )
                : const SizedBox();
          },
        ),
      ],
    );
  }
}
