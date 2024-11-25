import 'package:get/get.dart';

class FavoriteController extends GetxController {
  var title = 'Favorite'.obs;

  void updateTitle(String newTitle) {
    title.value = newTitle;
  }
}