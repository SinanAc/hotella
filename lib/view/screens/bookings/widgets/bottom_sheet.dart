import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:premio_inn/model/booked/booked_rooms.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/utils/strings.dart';
import 'package:premio_inn/view/widgets/button_widget.dart';
import 'package:premio_inn/view/widgets/loading_indicator.dart';
import 'package:premio_inn/view/widgets/shimmer_skelton.dart';
import 'package:premio_inn/view/widgets/show_dialogs.dart';
import 'package:premio_inn/view/widgets/text_widget.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';
import 'package:premio_inn/view_model/bookings/booking_view_model.dart';
import 'package:provider/provider.dart';

class BookedDetailsBottomSheet extends StatelessWidget {
  const BookedDetailsBottomSheet({
    Key? key,
    required this.hotel,
    required this.type,
  }) : super(key: key);
  final Completed hotel;
  final BookingEnums type;
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
            type == BookingEnums.coming
                ? 'Upcoming booking'
                : type == BookingEnums.completed
                    ? 'Completed'
                    : 'Cancelled',
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
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
                    Selector<BookedHotelsViewModel, bool>(
                      selector: (_, provider) => provider.cancelButtonLoading,
                      builder: (_, isLoad, __) {
                        return type == BookingEnums.coming
                            ? isLoad
                                ? const LoadingIndicator(
                                    color: KColors.kRedColor)
                                : ButtonWidget(
                                    text: 'Cancel booking',
                                    onTap: () {
                                      ShowDialogs.dialogBox(
                                          title: 'Cancel booking',
                                          messege:
                                              'Are you sure to want to cancel this booking?',
                                          goOn: () {
                                            Navigations.pop();
                                            bookingPro
                                                .cancelBooking(hotel.id ?? '');
                                          });
                                    },
                                    color: KColors.kRedColor,
                                  )
                            : const SizedBox();
                      },
                    ),
                    KSizedBox.kHeigh_40,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleWidget('Check-in', fontSize: 20),
                            KSizedBox.kHeigh_10,
                            TextWidget(DateFormat('EEE, MMM d, yyyy').format(
                                hotel.date?.startDate
                                        ?.add(const Duration(days: 1)) ??
                                    DateTime.now())),
                            KSizedBox.kHeigh_5,
                            TextWidget('${hotel.room?.checkinTime} onwards',
                                color: Colors.grey.shade700)
                          ],
                        ),
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            const SizedBox(
                              height: 60,
                              child: VerticalDivider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child:
                                      TextWidget('${hotel.days}N', size: 15)),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TitleWidget('Checkout', fontSize: 20),
                            KSizedBox.kHeigh_10,
                            TextWidget(DateFormat('EEE, MMM d, yyyy').format(
                                hotel.date?.endDate
                                        ?.add(const Duration(days: 1)) ??
                                    DateTime.now())),
                            KSizedBox.kHeigh_5,
                            TextWidget('Before ${hotel.room?.checkoutTime}',
                                color: Colors.grey.shade700)
                          ],
                        ),
                      ],
                    ),
                    const DividerWidget(),
                    DetailsWidget(
                        title: 'Booking ID',
                        subTitle: hotel.booingId ?? 'ID not available'),
                    const DividerWidget(),
                    DetailsWidget(
                        title: 'Rooms & Guests',
                        subTitle:
                            '${hotel.roomNumber} Room • ${hotel.room?.guest} Guests'),
                    const DividerWidget(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleWidget('Payment details', fontSize: 20),
                            KSizedBox.kHeigh_20,
                            TextWidget('Payment mode'),
                            KSizedBox.kHeigh_15,
                            TextWidget('Price per night'),
                            KSizedBox.kHeigh_15,
                            TextWidget('No of rooms'),
                            KSizedBox.kHeigh_15,
                            TextWidget('Total days'),
                            KSizedBox.kHeigh_15,
                            TextWidget('Total amount'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextWidget(hotel.paymentType ?? 'PAY AT HOTEL',
                                color: hotel.paymentType == 'ONLINE'
                                    ? KColors.kThemeGreen
                                    : const Color.fromARGB(255, 200, 5, 5)),
                            KSizedBox.kHeigh_15,
                            TextWidget('₹${hotel.room?.price.toString()}'),
                            KSizedBox.kHeigh_15,
                            TextWidget('${hotel.roomNumber}'),
                            KSizedBox.kHeigh_15,
                            TextWidget(hotel.days ?? 'Not available'),
                            KSizedBox.kHeigh_15,
                            TextWidget(
                              bookingPro.totalAmount(
                                hotel.roomNumber ?? 0,
                                hotel.room?.price ?? 0,
                                int.parse(hotel.days ?? '0'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    KSizedBox.kHeigh_20
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({Key? key, required this.title, required this.subTitle})
      : super(key: key);
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(title, fontSize: 20),
              KSizedBox.kHeigh_10,
              TextWidget(subTitle)
            ],
          ),
          title == 'Booking ID'
              ? IconButton(
                  icon: Icon(
                    Icons.copy_sharp,
                    color: Colors.grey.shade600,
                  ),
                  onPressed: () {},
                )
              : const SizedBox(),
        ],
      );
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Divider(
          thickness: 0.58,
          color: Colors.grey,
        ),
      );
}
