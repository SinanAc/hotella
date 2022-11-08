import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/view/widgets/back_button_widget.dart';
import 'package:premio_inn/view/widgets/main_card.dart';
import 'package:premio_inn/view/widgets/text_widget.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';
import 'package:premio_inn/view_model/category/category.dart';
import 'package:premio_inn/view_model/home/home_view_model.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
    required this.categoryName,
  });
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final categoryPro = Provider.of<CategoryViewModel>(context);
    final homePro = Provider.of<HomeViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: size.height / 5.8,
                width: size.width,
                child: const ColoredBox(
                  color: KColors.kThemeGreen,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BackButtonWidget(
                        buttonColor: Colors.grey.shade300,
                        iconColor: KColors.kThemeGreen,
                      ),
                      KSizedBox.kWidth_15,
                      TitleWidget(
                        categoryName,
                        fontSize: 24,
                        color: KColors.kThemeYellow,
                      ),
                      const Spacer(),
                      DropdownButton(
                        hint: TextWidget(
                          'Price',
                          color: Colors.grey.shade300,
                        ),
                        value: categoryPro.dropdownValue,
                        items: categoryPro.dropdownItems,
                        onChanged: (String? val) {
                          categoryPro.onDropdownChanged(
                              val, homePro.categoryWiseList, context);
                        },
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: Colors.grey.shade900,
                        iconEnabledColor: Colors.grey.shade300,
                        icon: const Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: Icon(Icons.sort),
                        ),
                        underline: const Text(''),
                      ),
                      KSizedBox.kWidth_15,
                    ],
                  ),
                  KSizedBox.kHeigh_5,
                  ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: homePro.categoryWiseList.length,
                    itemBuilder: ((context, index) {
                      return MainCard(hotel: homePro.categoryWiseList[index]);
                    }),
                    separatorBuilder: ((context, index) {
                      return KSizedBox.kHeigh_10;
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
