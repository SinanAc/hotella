import 'package:flutter/material.dart';
import 'package:premio_inn/model/home/all_rooms.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/screens/search/widgets/search_field.dart';
import 'package:premio_inn/view/widgets/main_card.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';
import 'package:premio_inn/view_model/home/home_view_model.dart';
import 'package:premio_inn/view_model/search/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchViewModel>(context);
    final homePro = context.read<HomeViewModel>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const SearchField(),
                KSizedBox.kHeigh_15,
                Selector<SearchViewModel, List<String>>(
                  selector: (_, obj) => obj.searchCityList,
                  builder: (__, list, _) => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (_, index) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        title: TitleWidget(list[index]),
                        tileColor: const Color.fromARGB(29, 3, 2, 0),
                        onTap: () {
                          searchProvider.getSearchResults(
                            city: list[index],
                            allRooms: homePro.allRooms,
                          );
                          list.clear();
                        },
                      ),
                    ),
                  ),
                ),
                KSizedBox.kHeigh_5,
                Selector<SearchViewModel, List<AllRoomsModel>>(
                  selector: (_, obj) => obj.searchResultList,
                  builder: (__, list, _) => list.isEmpty
                      ? ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: homePro.allRooms.length,
                          itemBuilder: (_, index) =>
                              MainCard(hotel: homePro.allRooms[index]),
                          separatorBuilder: (_, __) => KSizedBox.kHeigh_10,
                        )
                      : ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: list.length,
                          itemBuilder: (_, index) =>
                              MainCard(hotel: list[index]),
                          separatorBuilder: (_, __) => KSizedBox.kHeigh_10,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
