import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premio_inn/view_model/home/home_view_model.dart';
import 'package:premio_inn/view_model/search/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final homePro = context.read<HomeViewModel>();
    final searchPro = context.read<SearchViewModel>();
    return TextField(
      onChanged: (value) {
        searchPro.runSearchFilter(
            enteredKeyword: value, cities: homePro.allCities);
      },
      decoration: InputDecoration(
          fillColor: Colors.grey.shade400,
          filled: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Icon(
              CupertinoIcons.search,
              color: Colors.grey.shade800,
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          hintText: 'Search by city...',
          hintStyle: TextStyle(color: Colors.grey.shade700, fontSize: 18),
          contentPadding: const EdgeInsets.all(15)),
      style: TextStyle(
        color: Colors.grey.shade800,
      ),
    );
  }
}
