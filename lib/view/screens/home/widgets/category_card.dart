import 'package:flutter/material.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.img,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final String img;
  final String title;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        InkWell(
          onTap: () {
            onTap();
          },
          child: Container(
            height: size.width / 4,
            width: size.width / 3.4,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(52, 6, 0, 0),
            ),
            child: Image.asset(img),
          ),
        ),
        const SizedBox(height: 1.5),
        TitleWidget(
          text: title,
          fontSize: 14,
          color: const Color.fromARGB(184, 255, 253, 253),
        ),
      ],
    );
  }
}
