import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bottomNav/bottom_nav_controller.dart';

class BottomNavBar extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
      currentIndex: controller.selectedIndex.value,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.collections),
          label: 'Sport',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            controller.goToSport();
            break;
          case 1:
            controller.goToFavorite();
            break;
          case 2:
            controller.goToProfile();
            break;
        }
      },
    ));
  }
}