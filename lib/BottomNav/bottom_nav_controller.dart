import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  void goToSport() {
    selectedIndex.value = 0;
    Get.toNamed('/sport');
  }

  void goToFavorite() {
    selectedIndex.value = 1;
    Get.toNamed('/favorite');
  }

  void goToProfile() {
    selectedIndex.value = 2;
    Get.toNamed('/profile');
  }

  void goToLogin() {
    Get.toNamed('/');
  }
}