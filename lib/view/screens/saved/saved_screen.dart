import 'package:flutter/material.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return const Padding(
      padding:  EdgeInsets.all(8.0),
      // child: GridView.builder(
      //   itemCount: 4,
      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 2,
      //       crossAxisSpacing: 6.0,
      //       mainAxisSpacing: 6.0,
      //       ),
      //   itemBuilder: (context, index) {
      //     return  MainCard(name: 'Fabulous Dines', loaction: 'Delhi', img: 'assets/images/hotel_dummy.jpg', size: size);
      //   },
      // ),
    );
  }
}
