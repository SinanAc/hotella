import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
          fillColor: Color.fromARGB(52, 6, 0, 0),
          filled: true,
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 20,right: 10),
            child: Icon(
              CupertinoIcons.search,
              color: Colors.white54,
            ),
          ),
          enabled: false,
          contentPadding: EdgeInsets.all(16),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              hintText: 'Search here...',
              hintStyle: TextStyle(
                color: Colors.white38,
              )
              ),
      style: const TextStyle(
        color: Colors.white38,
      ),
      onChanged: (value) {
        if (value.isEmpty) {
          return;
        }
      },
      onTap: () {},
      readOnly: true,
    );
  }
}
