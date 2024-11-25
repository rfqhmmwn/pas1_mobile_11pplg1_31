import 'package:get/get.dart';

class ProfileController extends GetxController {
  var title = 'Profile'.obs;

  void updateTitle(String newTitle) {
    title.value = newTitle;
  }
}