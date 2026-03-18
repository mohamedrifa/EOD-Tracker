import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/eod_model.dart';

class ApiService {
  static const String baseUrl = "https://eod-backend-ykjw.onrender.com/api";

  // Login
  static Future<http.Response> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/User/login");

    return await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "password": password,
        "twoFactorCode": "",
        "twoFactorRecoveryCode": "",
      }),
    );
  }

  // Signup
  static Future<http.Response> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/User");

    return await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "id": "",
        "name": name,
        "email": email,
        "password": password,
      }),
    );
  }

  // get tasks by date
  static Future<List<Eod>> getTasksByDate({
    required String userId,
    required DateTime date,
  }) async {
    String formattedDate =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    final url = Uri.parse("$baseUrl/Eod/user/$userId/date/$formattedDate");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data as List).map((item) {
        return Eod(
          id: item['id'],
          topic: item['topic'],
          expectedTime: item['expectedTime'],
          actualTime: item['actualTime'],
          description: item['description'],
          status: item['status'],
        );
      }).toList();
    } else {
      throw Exception("Failed to load tasks");
    }
  }

  // Save EOD
  static Future<bool> saveEod({
    required String? id,
    required String topic,
    required String userId,
    required String expectedTime,
    required String actualTime,
    required String description,
    required String status,
    required DateTime createdAt,
  }) async {

    final url = id == null
        ? Uri.parse("$baseUrl/Eod")
        : Uri.parse("$baseUrl/Eod/$id");

    final method = id == null ? "POST" : "PUT";

    final body = jsonEncode({
      "topic": topic,
      "userId": userId,
      "expectedTime": expectedTime,
      "actualTime": actualTime,
      "description": description,
      "status": status,
      "createdAt": createdAt.toIso8601String(),
    });

    final request = http.Request(method, url)
      ..headers['Content-Type'] = 'application/json'
      ..body = body;

    final streamed = await request.send();
    final res = await http.Response.fromStream(streamed);

    return res.statusCode == 200 || res.statusCode == 201;
  }

  // Delete EOD
  static Future<bool> deleteEod(String id) async {
    final url = Uri.parse("$baseUrl/Eod/$id");

    final res = await http.delete(url);

    return res.statusCode == 200 || res.statusCode == 204;
  }

  // Get User
  static Future<Map<String, dynamic>?> getUser(String id) async {
    final url = Uri.parse("$baseUrl/User/$id");
    final res = await http.get(url);
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }
    return null;
  }

  // Update User
  static Future<bool> updateUser({
    required String id,
    required String name,
    required String email,
    String? password,
  }) async {
    final url = Uri.parse("$baseUrl/User/$id");
    final res = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id": id,
        "name": name,
        "email": email,
        "password": password,
      }),
    );
    return res.statusCode == 200;
  }

  //Update Password
  static Future<bool> updatePassword({
    required String id,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await http.put(
        Uri.parse("https://eod-backend-ykjw.onrender.com/api/User/$id/password"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "oldPassword": oldPassword,
          "newPassword": newPassword,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Password update error: $e");
      return false;
    }
  }
}