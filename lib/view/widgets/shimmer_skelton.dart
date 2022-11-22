import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSkelton extends StatelessWidget {
  const ShimmerSkelton({
    Key? key,
    required this.height,
    required this.width,
    this.radius = 10,
    this.color = Colors.white,
  }) : super(key: key);
  final double height;
  final double width;
  final double radius;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade400,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
