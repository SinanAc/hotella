import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/view/screens/search/search_screen.dart';
import 'package:premio_inn/view_model/home/home_view_model.dart';
import 'package:provider/provider.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key, required this.isHome}) : super(key: key);
  final bool isHome;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        if (isHome) {
          Provider.of<HomeViewModel>(context, listen: false).fetchAllCities();
          Navigations.push(const SearchScreen());
        } else {
          null;
        }
      },
      decoration: InputDecoration(
          fillColor:
              isHome ? const Color.fromARGB(52, 6, 0, 0) : Colors.grey.shade400,
          filled: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Icon(
              CupertinoIcons.search,
              color: isHome ? Colors.white38 : Colors.grey.shade800,
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          hintText: 'Search here...',
          hintStyle: TextStyle(
            color: isHome ? Colors.white38 : Colors.grey.shade700,
          ),
          contentPadding: const EdgeInsets.all(15)),
      style: const TextStyle(
        color: Colors.white38,
      ),
      readOnly: isHome,
    );
  }
}
