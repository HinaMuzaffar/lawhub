import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:5000/users'; // Android emulator uses 10.0.2.2

  Future<List<User>> getUsers() async {
    final res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) {
      List body = jsonDecode(res.body);
      return body.map((e) => User.fromJson(e)).toList();
    }
    throw Exception('Failed to load users');
  }

  Future<User> createUser(User user) async {
    final res = await http.post(Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(user.toJson()));
    return User.fromJson(jsonDecode(res.body));
  }

  Future<User> updateUser(String id, User user) async {
    final res = await http.put(Uri.parse('$baseUrl/$id'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(user.toJson()));
    return User.fromJson(jsonDecode(res.body));
  }

  Future<void> deleteUser(String id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}

