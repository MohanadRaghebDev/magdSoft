import 'package:flutter/material.dart';

import '../presentation/styles/colors.dart';

const TextStyle userDataTxtStyle =
    TextStyle(color: AppColor.mainColor, fontSize: 25);

BoxDecoration langButtonDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(15),
);

const BoxDecoration signInFormDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(40),
    topRight: Radius.circular(40),
  ),
);
