import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicatorWidget extends SmoothPageIndicator {
  PageIndicatorWidget({
    Key? key,
    required super.controller,
    required super.count,
    super.effect = const ExpandingDotsEffect(
      activeDotColor: Colors.white,
      dotColor: Colors.white70,
      dotHeight: 7,
      dotWidth: 7,
    ),
  }) : super(key: key);
}
