import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premio_inn/utils/navigations.dart';
import 'package:premio_inn/view/screens/search/search_screen.dart';
import 'package:premio_inn/view_model/home/home_view_model.dart';
import 'package:premio_inn/view_model/search/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final searchPro = context.read<SearchViewModel>();
    return TextField(
      onTap: () {
        Provider.of<HomeViewModel>(context, listen: false).fetchAllCities();
        searchPro.searchCityList.clear();
        searchPro.searchResultList.clear();
        Navigations.push(const SearchScreen());
      },
      decoration: const InputDecoration(
        fillColor: Color.fromARGB(52, 6, 0, 0),
        filled: true,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20, right: 10),
          child: Icon(
            CupertinoIcons.search,
            color: Colors.white38,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        hintText: 'Search here...',
        hintStyle: TextStyle(
          color: Colors.white38,
        ),
        contentPadding: EdgeInsets.all(15),
      ),
      style: const TextStyle(
        color: Colors.white38,
      ),
      readOnly: true,
    );
  }
}
