import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:premio_inn/model/booked/booked_rooms.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/utils/strings.dart';
import 'package:premio_inn/view/widgets/shimmer_skelton.dart';
import 'package:premio_inn/view/widgets/text_widget.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';

class HotelCard extends StatelessWidget {
  const HotelCard({Key? key, required this.hotel}) : super(key: key);
  final Completed hotel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
        elevation: 0,
        child: Row(
          children: [
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
            KSizedBox.kWidth_10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleWidget(hotel.property?.city ?? 'City name not available',
                    fontSize: 18),
                KSizedBox.kHeigh_5,
                TextWidget(
                    '${DateFormat('MMM d').format(hotel.date?.startDate ?? DateTime.now())} - ${DateFormat('MMM d').format(hotel.date?.endDate ?? DateTime.now())} • ${hotel.room?.guest.toString()} Guests',
                    size: 17,),
                KSizedBox.kHeigh_5,
                SizedBox(
                  width: size.width / 1.8,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    hotel.property?.propertyName ?? 'Hotel name not available',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                KSizedBox.kHeigh_5,
                SizedBox(
                  width: size.width / 1.9,
                  child: Text(
                    hotel.property?.address ?? 'Address not available',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
