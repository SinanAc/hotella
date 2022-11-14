import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:premio_inn/model/booked/booked_rooms.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/utils/strings.dart';
import 'package:premio_inn/view/widgets/button_widget.dart';
import 'package:premio_inn/view/widgets/shimmer_skelton.dart';
import 'package:premio_inn/view/widgets/text_widget.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';
import 'package:premio_inn/view_model/bookings/booking_view_model.dart';
import 'package:provider/provider.dart';

class BookedDetailsBottomSheet extends StatelessWidget {
  const BookedDetailsBottomSheet({
    Key? key,
    required this.hotel,
  }) : super(key: key);
  final Completed hotel;
  @override
  Widget build(BuildContext context) {
    final bookingPro = Provider.of<BookedHotelsViewModel>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black.withOpacity(0.6),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        KSizedBox.kHeigh_30,
        IconButton(
          onPressed: () {
            Navigations.pop();
          },
          icon: const Icon(
            Icons.clear,
            color: Colors.white70,
          ),
        ),
        KSizedBox.kHeigh_10,
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TitleWidget(
            'Upcoming booking',
            color: Colors.white,
            fontSize: 26,
          ),
        ),
        KSizedBox.kHeigh_15,
        Expanded(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: KColors.kLieWhiteColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                children: [
                  KSizedBox.kHeigh_20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width / 1.8,
                            child: TitleWidget(
                                hotel.property?.propertyName ??
                                    'Hotel name not available',
                                fontSize: 24),
                          ),
                          KSizedBox.kHeigh_5,
                          // TextWidget(
                          //   '${DateFormat('MMM d').format(hotel.date?.startDate ?? DateTime.now())} - ${DateFormat('MMM d').format(hotel.date?.endDate ?? DateTime.now())} • ${hotel.room?.guest.toString()} Guests',
                          //   size: 17,
                          // ),
                          SizedBox(
                            width: size.width / 1.8,
                            child: Text(
                              hotel.property?.address ??
                                  'Address not available',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          )
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                          height: size.height / 6.7,
                          width: size.height / 6.7,
                          fit: BoxFit.cover,
                          imageUrl: hotel.room?.images?.first.first.url ??
                              KStrings.dummyNetImage,
                          placeholder: (context, url) => ShimmerSkelton(
                            height: size.height / 6.7,
                            width: size.height / 6.7,
                          ),
                          errorWidget: (context, url, error) =>
                              Image.asset(KStrings.noInterNetImage),
                        ),
                      ),
                    ],
                  ),
                  KSizedBox.kHeigh_15,
                  ButtonWidget(
                    text: 'Cancell booking',
                    onTap: () {},
                    color: KColors.kRedColor,
                  ),
                  KSizedBox.kHeigh_30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleWidget('Check-in', fontSize: 20),
                          KSizedBox.kHeigh_5,
                          TextWidget(DateFormat('EEE, MMM d, yyyy')
                              .format(hotel.date?.startDate ?? DateTime.now())),
                          KSizedBox.kHeigh_3,
                          TextWidget(
                              '${hotel.room?.checkinTime} onwards',
                              color: Colors.grey.shade700)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TitleWidget('Checkout', fontSize: 20),
                          KSizedBox.kHeigh_5,
                          TextWidget(DateFormat('EEE, MMM d, yyyy')
                              .format(hotel.date?.endDate ?? DateTime.now())),
                          KSizedBox.kHeigh_3,
                          TextWidget(
                              'Before ${hotel.room?.checkoutTime}',
                              color: Colors.grey.shade700)
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
