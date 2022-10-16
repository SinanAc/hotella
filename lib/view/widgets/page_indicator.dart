import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicatorWidget extends StatelessWidget {
  const PageIndicatorWidget({
    Key? key,
    required this.controller,
    required this.count
  }) : super(key: key);

  final PageController controller;
  final int count;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect:  const ExpandingDotsEffect(
        activeDotColor: Colors.white,
        dotColor: Colors.white70,
        dotHeight: 7,
        dotWidth: 7,
      ),
    );
  }
}
