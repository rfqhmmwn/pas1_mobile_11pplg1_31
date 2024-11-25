import 'package:get/get.dart';
import 'sportModel.dart';
import 'sportService.dart';
import 'package:flutter/material.dart';

class SportController extends GetxController {
  var isLoading = true.obs;
  var postList = <Welcome>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() async {
    try {
      isLoading(true);
      var posts = await SportService.fetchPosts();
      print('${posts.length} items');
      
      if (posts.isNotEmpty) {
        postList.assignAll(posts);
        print('${postList.length}');
      } else {
        print('Tidak ada data');
      }
    } catch (e) {
      print('Error in fetchPosts: $e');
      Get.snackbar(
        'Error',
        'Gagal memuat data: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }
}