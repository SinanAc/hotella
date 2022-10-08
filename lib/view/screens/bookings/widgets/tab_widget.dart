import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Tab(
      height: MediaQuery.of(context).size.height/18,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            ),
        child: Align(
          alignment: Alignment.center,
          child:
              Text(text, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
        ),
      ),
    );
  }
}