import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_study/utils/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../environment/environment.dart';
import '../models/user_model.dart';
import '../services/interceptor.dart';

final env = Environment();

final storage = LocalStorage();

final interceptor = Interceptor();

Future<dynamic> register(String body) async {
  Map<String, String> header = {'Content-Type': 'application/json'};

  try {
    final response = await http.post(Uri.parse('${env.urlBase}/user'),
        body: body, headers: header);

    Map<String, dynamic> responseBody;

    responseBody = jsonDecode(response.body);

    if (responseBody.containsValue('ER_DUP_ENTRY')) {
      return 'ER_DUP_ENTRY';
    } else {
      return response;
    }
  } catch (e) {
    throw Exception('Error in create user');
  }
}

Future<UserModel> login(Map<String, String> body) async {
  try {
    final response =
        await http.post(Uri.parse('${env.urlBase}/user/login'), body: body);

    return UserModel.fromMap(jsonDecode(response.body));
  } catch (e) {
    throw Exception('Erro ao fazer o login');
  }
}

Future<UserModel> getUserById(int userId) async {
  try {
    String? token = '';

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    final userLocal = await storage.getUserStorage();

    if (userLocal != null) {
      token = userLocal.token;
    }

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await interceptor
        .get(Uri.parse('${env.urlBase}/user/$userId'), headers: header);

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error');
    }
  } catch (e) {
    throw Exception('Error');
  }
}

Future<List<dynamic>> verifyUserNameExists(String userName) async {
  try {
    String? token = '';

    final userLocal = await storage.getUserStorage();

    if (userLocal != null) {
      token = userLocal.token;
    }

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await interceptor.get(
        Uri.parse('${env.urlBase}/user/createUserNameUnique/$userName'),
        headers: header);

    return jsonDecode(response.body);
  } catch (e) {
    throw Exception('Error');
  }
}

Future<String?> refreshToken() async {
  try {
    String? token = '';
    await storage.getUserToken().then(
          (value) => {
            token = value,
          },
        );

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    Map<String, dynamic> body = {'oldToken': token};

    localStorage.setString('oldToken', token!);

    http.Response response = await http
        .post(Uri.parse('${env.urlBase}/token/refreshToken'), body: body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      String resp;
      final user = UserModel.fromMap(jsonDecode(response.body));

      resp = jsonEncode(user);

      bool saveSuccessful = await localStorage.setString('user', resp);

      if (saveSuccessful) {
        final userLocal = await storage.getUserStorage();

        if (userLocal != null) {
          return userLocal.token;
        }
      }
    }
  } catch (e) {
    throw Exception('Error in create user');
  }
}

Future<dynamic> validateToken() async {
  try {
    String? token = '';
    await storage.getUserToken().then((value) => {
          token = value,
        });

    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    http.Response response = await http.get(
        Uri.parse('${env.urlBase}/user/token/validateToken'),
        headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final validate = response.body;

      return validate;
    } else {
      response.statusCode;
    }
  } catch (e) {
    throw Exception('$e ,Error');
  }
}
