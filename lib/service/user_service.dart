import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class UserService {
  final String baseUrl = 'http://localhost:3000/api';

  Future<bool> register(UserModel user) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> login(UserModel user) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
