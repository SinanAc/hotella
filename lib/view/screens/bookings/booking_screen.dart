import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/screens/bookings/widgets/coming_screen.dart';
import 'package:premio_inn/view/screens/bookings/widgets/history_screen.dart';
import 'package:premio_inn/view/screens/bookings/widgets/tab_widget.dart';
import 'package:premio_inn/view/widgets/double_color_title.dart';
import 'package:premio_inn/view/widgets/loading_indicator.dart';
import 'package:premio_inn/view_model/booked/bookings.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingsPro = context.read<BookedHotelsViewModel>();
    return FutureBuilder(
      future: bookingsPro.getAllBookedHotels(),
      builder: (_, __) => DefaultTabController(
        length: 2,
        child: Column(
          children: [
            ColoredBox(
              color: KColors.kWhiteColor,
              child: Column(
                children: [
                  KSizedBox.kHeigh_10,
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                    child: DoubleColorTitle(
                        text1: 'My', text2: 'Bookings', textSize: 24),
                  ),
                  TabBar(
                    unselectedLabelColor: Colors.grey.shade500,
                    labelColor: KColors.kLiteGreen,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: const [
                      TabWidget(text: 'Coming'),
                      TabWidget(text: 'History'),
                    ],
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: KColors.kTabBarColor,
                    ),
                  ),
                  KSizedBox.kHeigh_10,
                ],
              ),
            ),
            KSizedBox.kHeigh_10,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: bookingsPro.isLoading
                    ? const LoadingIndicator()
                    : bookingsPro.bookedHotels.isEmpty
                        ? const Center(child: Text('No records found'))
                        : const TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                                ComingScreen(),
                                HistoryScreen(),
                              ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
