import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/view/widgets/single_color_title.dart';

class MainCard extends StatelessWidget {
  const MainCard({
    Key? key,
    required this.name,
    required this.loaction,
    required this.img,
    required this.size,
  }) : super(key: key);
  final String name;
  final String loaction;
  final String img;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 3.7,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            const Spacer(),
            Row(
              children: [
                Container(
                  decoration:  BoxDecoration(
                    color: const Color.fromARGB(123, 0, 0, 0),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  padding: const EdgeInsets.symmetric(horizontal:12,vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleColorTitle(
                        text: name,
                        fontSize: 18,
                        color: KColors.kWhiteColor,
                      ),
                      SingleColorTitle(
                        text: loaction,
                        fontSize: 15,
                        color: KColors.kWhiteColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
