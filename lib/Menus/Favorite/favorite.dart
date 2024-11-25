import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_31/Menus/Sport/sportModel.dart';
import '../../database/db_helper.dart';
import '../../bottomNav/bottom_nav.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late Future<List<Welcome>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    _favoritesFuture = DatabaseHelper.instance.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite Sports',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder<List<Welcome>>(
          future: _favoritesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No favorite sports found.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }

            final favorites = snapshot.data!;

            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final sport = favorites[index];
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
                        sport.strTeamBadge != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  sport.strTeamBadge!,
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
                                sport.strTeam,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Favorite Team',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Delete Button
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await DatabaseHelper.instance
                                .removeFavorite(sport.idTeam);
                            Get.snackbar(
                              'Deleted',
                              '${sport.strTeam} removed from favorites',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white,
                            );
                            setState(() {
                              _loadFavorites();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
