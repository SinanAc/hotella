import 'package:flutter/material.dart';
import 'package:premio_inn/utils/sizes.dart';

class ComingScreen extends StatelessWidget {
  const ComingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: 8,
        itemBuilder: ((context, index) {
          return const SizedBox();
          // MainCard(
          //   name: 'Vistara egmondo',
          //   loaction: 'Genevia',
          //   img: 'assets/images/hotel_dummy.jpg',
          //   size: MediaQuery.of(context).size,
          // );
        }),
        separatorBuilder: ((context, index) {
          return KSizedBox.kHeigh_10;
        }));
  }
}
