import 'sportController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../bottomNav/bottom_nav.dart';
import '../../database/db_helper.dart';

class SportView extends StatelessWidget {
  final SportController sportController = Get.put(SportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sport List'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Obx(() {
        if (sportController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (sportController.postList.isEmpty) {
          return const Center(
            child: Text(
              'No Data Available',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: sportController.postList.length,
          itemBuilder: (context, index) {
            final post = sportController.postList[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Team Badge
                    post.strTeamBadge != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              post.strTeamBadge!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.sports_soccer,
                                  size: 50,
                                  color: Colors.grey,
                                );
                              },
                            ),
                          )
                        : Icon(
                            Icons.sports_soccer,
                            size: 80,
                            color: Colors.grey[300],
                          ),
                    const SizedBox(width: 15),
                    // Team Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.strTeam,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Football Team',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    // Favorite Button
                    IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.redAccent,
                      ),
                      onPressed: () async {
                        try {
                          bool exists = await DatabaseHelper.instance
                              .checkFavorite(post.idTeam);

                          if (!exists) {
                            await DatabaseHelper.instance.addFavorite(post);
                            Get.snackbar(
                              'Success',
                              '${post.strTeam} added to favorites',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                              duration: const Duration(seconds: 2),
                            );
                          } else {
                            Get.snackbar(
                              'Info',
                              '${post.strTeam} is already in favorites',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.blue,
                              colorText: Colors.white,
                              duration: const Duration(seconds: 2),
                            );
                          }
                        } catch (error) {
                          print('Error adding to favorites:');
                          Get.snackbar(
                            'Error',
                            'Failed to add to favorites:',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            duration: const Duration(seconds: 2),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
