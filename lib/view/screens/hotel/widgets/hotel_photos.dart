import 'package:flutter/material.dart';
import 'package:premio_inn/model/home/all_rooms_model/all_rooms.dart';

class HotelPhotos extends StatelessWidget {
  const HotelPhotos({
    Key? key,
    required this.size,
    required this.hotel,
  }) : super(key: key);
  final Size size;
  final AllRoomssModel? hotel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: size.height / 2.7,
          width: size.width,
        ),
        Positioned(
            top: 0,
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Image.network(
                  '${hotel?.images?.first[index].url}',
                  height: size.height / 2.7,
                  width: size.width,
                  fit: BoxFit.cover,
                  );
              },
              itemCount: hotel?.images?.first.length,
            )),
      ],
    );
  }
}
