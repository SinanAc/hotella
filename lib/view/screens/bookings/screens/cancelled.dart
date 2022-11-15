import 'package:flutter/material.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/screens/bookings/widgets/hotel_card.dart';
import 'package:premio_inn/view_model/bookings/booking_view_model.dart';
import 'package:provider/provider.dart';

class CancelledScreen extends StatelessWidget {
  const CancelledScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingsPro = context.read<BookedHotelsViewModel>();
    return bookingsPro.cancelledList.isEmpty
        ? const Center(child: Text('No records found'))
        : ListView.separated(
            itemCount: bookingsPro.cancelledList.length,
            itemBuilder: ((_, index) {
              return HotelCard(
                hotel: bookingsPro.cancelledList[index],
                type:  BookingEnums.cancelled,
                );
            }),
            separatorBuilder: ((_, __) {
              return KSizedBox.kHeigh_10;
            }),
          );
  }
}
