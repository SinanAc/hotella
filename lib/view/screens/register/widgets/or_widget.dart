import 'package:flutter/material.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width / 2.8,
            child: const Divider(color: Colors.white, thickness: 0.6)),
        const Text(
          'OR',
          style: TextStyle(color: Colors.white54),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width / 2.8,
            child: const Divider(color: Colors.white, thickness: 0.6)),
      ],
    );
  }
}
