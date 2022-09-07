import 'package:flutter/material.dart';
import 'package:shop_app/screen/Screens/home/shop_home_screen.dart';
import 'package:shop_app/styles/themes.dart';

import 'screen/Screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: orginThem(),
      home: ShopHomeScreen(),
    );
  }
}
