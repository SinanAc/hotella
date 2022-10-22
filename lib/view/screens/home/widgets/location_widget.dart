import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/view/widgets/text_widget.dart';
import 'package:premio_inn/view_model/home/home_view_model.dart';
import 'package:provider/provider.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: ((ctx, value, _) {
        return Row(
          children: [
            const Icon(
              Icons.place,
              color: Colors.white70,
              size: 22,
            ),
            const SizedBox(width: 2),
            // value.userLocation.isEmpty && value.isLocationLoading
            //     ? const ShimmerSkelton(
            //         height: 20,
            //         width: 200,
            //         radius: 5,
            //         color: Color.fromARGB(77, 255, 255, 255),
            //       )
            //     :
            value.userLocation.isEmpty || value.userLocation.isEmpty
                ? TextButton(
                    onPressed: () {
                      value.getUserLocation();
                    },
                    child: const Text(
                      'Get current location',
                      style: TextStyle(color: KColors.kBlueColor, fontSize: 16),
                    ),
                  )
                : TextWidget(
                    text: value.userLocation,
                    color: const Color.fromARGB(137, 255, 255, 255),
                    size: 16,
                  ),
          ],
        );
      }),
    );
  }
}
