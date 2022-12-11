import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';
import 'package:premio_inn/utils/sizes.dart';
import 'package:premio_inn/utils/strings.dart';
import 'package:premio_inn/view/widgets/title_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({
    Key? key,
  }) : super(key: key);
  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  String userName = 'User name';
  String mobileNum = 'Contact number';
  Future<void> getStoredUserData() async {
    final SharedPreferences pref;
    pref = await SharedPreferences.getInstance();
    userName = pref.getString(KStrings.userName) ?? '';
    mobileNum = pref.getString(KStrings.phone) ?? '';
  }

  @override
  void initState() {
    super.initState();
    getStoredUserData();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: getStoredUserData(),
        builder: (_, __) => Card(
          elevation: 0,
          color: KColors.kWhiteColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/images/user_icon.png'),
                ),
                KSizedBox.kWidth_20,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleWidget(
                      userName,
                      fontSize: 20,
                    ),
                    KSizedBox.kHeigh_5,
                    TitleWidget(
                      '+91 $mobileNum',
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
