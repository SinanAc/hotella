import 'package:flutter/material.dart';
import 'package:premio_inn/utils/sizes.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: 2,
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
