import 'dart:convert';
import 'package:http/http.dart' as http;
import 'sportModel.dart';

class SportService {
  static const String baseUrl = 'https://www.thesportsdb.com/api/v1/json/3/search_all_teams.php?l=English%20Premier%20League';

  static Future<List<Welcome>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> teams = jsonResponse['teams'] ?? [];
        
        return teams.map((json) => Welcome.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load teams');
      }
    } catch (error) {
      print('Error in fetchPosts: $error');
      throw Exception('Error: $error');
    }
  }
} 