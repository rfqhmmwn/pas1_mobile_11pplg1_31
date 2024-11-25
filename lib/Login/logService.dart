import 'dart:convert';
import 'package:http/http.dart' as http;
import 'logModel.dart';

class LogService {
  final String baseUrl = 'https://mediadwi.com/api/latihan/login';

  Future<LogModel> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return LogModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to login');
    }
  }
}