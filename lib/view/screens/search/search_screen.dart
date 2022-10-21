import 'package:flutter/material.dart';
import 'package:premio_inn/view/screens/home/widgets/search_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: const [
                SearchField(isHome: false),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}