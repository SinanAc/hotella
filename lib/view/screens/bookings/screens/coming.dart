import 'package:flutter/material.dart';
import 'package:premio_inn/model/booked/booked_rooms.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/screens/bookings/widgets/hotel_card.dart';
import 'package:premio_inn/view_model/bookings/booking_view_model.dart';
import 'package:provider/provider.dart';

class ComingScreen extends StatelessWidget {
  const ComingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingsPro = context.read<BookedHotelsViewModel>();
    return bookingsPro.upcomingList.isEmpty
        ? const Center(child: Text('No records found'))
        : Selector<BookedHotelsViewModel, List<Completed>>(
            selector: (_, provider) => provider.upcomingList,
            builder: (_, value, __) => ListView.separated(
              itemCount: value.length,
              itemBuilder: (_, index) => HotelCard(
                hotel: value[index],
                type: BookingEnums.coming,
              ),
              separatorBuilder: (_, __) => KSizedBox.kHeigh_10,
            ),
          );
  }
}
