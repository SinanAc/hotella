import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicatorWidget extends StatelessWidget {
  const PageIndicatorWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: 3,
      effect: const ExpandingDotsEffect(
        activeDotColor: KColors.kLiteGreen,
        dotColor: Color.fromARGB(77, 15, 102, 87),
        dotHeight: 7,
        dotWidth: 7,
      ),
    );
  }
}
