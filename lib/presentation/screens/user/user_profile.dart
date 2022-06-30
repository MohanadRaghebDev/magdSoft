import 'package:flutter/material.dart';
import 'package:magdsoft_flutter_structure/data/local/cache_helper.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/auth_screen/login_screen.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/sign_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../constants/constants.dart';

class UserProfile extends StatelessWidget {
  UserProfile({Key? key}) : super(key: key);

  String name = CacheHelper.getDataFromSharedPreference(key: 'name');
  String email = CacheHelper.getDataFromSharedPreference(key: 'email');
  String phone = CacheHelper.getDataFromSharedPreference(key: 'phone');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          AppLocalizations.of(context)!.userData,
          style: const TextStyle(
            fontSize: 30,
          ),
        )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 200,
          ),
          Padding(
            padding:
                CacheHelper.getDataFromSharedPreference(key: 'language') == 'en'
                    ? const EdgeInsets.only(left: 40)
                    : const EdgeInsets.only(right: 40),
            child: Column(
              crossAxisAlignment:
                  CacheHelper.getDataFromSharedPreference(key: 'language') ==
                          'en'
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
              children: [
                Text(
                  'Name : $name',
                  style: userDataTxtStyle,
                ),
                Text(
                  'Email : $email',
                  style: userDataTxtStyle,
                ),
                Text(
                  'phone : $phone',
                  style: userDataTxtStyle,
                ),
              ],
            ),
          ),
          const Spacer(),
          Center(
            child: SignButton(
                colour: AppColor.logOutButtonColor,
                onPressing: () {
                  CacheHelper.removeData(key: 'name');
                  CacheHelper.removeData(key: 'email');
                  CacheHelper.removeData(key: 'phone');
                  CacheHelper.removeData(key: 'login');
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                buttonText: AppLocalizations.of(context)!.logout),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
