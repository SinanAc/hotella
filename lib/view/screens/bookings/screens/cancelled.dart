import 'package:flutter/material.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view_model/booked/bookings.dart';
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
              return const SizedBox(
                width: 100,
                child: ColoredBox(
                  color: Colors.black,
                  child: SizedBox(
                    height: 100,
                  ),
                ),
              );
            }),
            separatorBuilder: ((_, __) {
              return KSizedBox.kHeigh_10;
            }));
  }
}