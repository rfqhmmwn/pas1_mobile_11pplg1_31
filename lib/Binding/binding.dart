import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_31/Menus/Favorite/favoriteController.dart';
import 'package:pas1_mobile_11pplg1_31/Menus/Profile/profileController.dart';
import 'package:pas1_mobile_11pplg1_31/Menus/Sport/sportController.dart';


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SportController>(() => SportController());
    Get.lazyPut<FavoriteController>(() => FavoriteController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}