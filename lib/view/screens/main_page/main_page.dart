import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:premio_inn/view_model/main_page/main_page_view_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<MainPageViewModel, int>(
      selector: ((_, provider) => provider.bottomNavIndex),
      builder: (_, bottomIndexes, __) => Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        body: SafeArea(
          child: MainPageViewModel.screenList[bottomIndexes],
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: bottomIndexes,
          onItemSelected: (index) {
            Provider.of<MainPageViewModel>(context,listen: false).changeBottomIndex(index);
          },
          items: [
            MainPageViewModel.bottomItems[0],
            MainPageViewModel.bottomItems[1],
            // MainPageViewModel.bottomItems[2],
            MainPageViewModel.bottomItems[3],
          ],
          itemCornerRadius: 10,
        ),
      ),
    );
  }
}
