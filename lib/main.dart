import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_31/Menus/Favorite/favorite.dart';
import 'package:pas1_mobile_11pplg1_31/Menus/Profile/profile.dart';
import 'package:pas1_mobile_11pplg1_31/Menus/Sport/sportView.dart';
import '../Binding/binding.dart';
import '../Login/logView.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await getDatabasesPath();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(name: '/', page: () => LogView()),
        GetPage(name: '/login', page: () => LogView()),
        GetPage(
          name: '/sport',
          page: () => SportView(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/favorite',
          page: () => FavoritePage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/profile',
          page: () => Profile(),
          binding: HomeBinding(),
        ),
      ],
      initialRoute: '/',
    );
  }
}