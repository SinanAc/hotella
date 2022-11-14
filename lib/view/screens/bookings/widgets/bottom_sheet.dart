import 'package:flutter/material.dart';
import 'package:premio_inn/model/booked/booked_rooms.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/utils/sizes.dart';
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
            'Checked out',
            color: Colors.white,
            fontSize: 26,
          ),
        ),
        KSizedBox.kHeigh_15,
        Expanded(
          child: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                color: Colors.white),
          ),
        )
      ]),
    );
  }
}
