import 'package:http/http.dart' as http;

import '../auth/auth_controller.dart';

class Interceptor extends http.BaseClient {
  final http.Client _httpClient = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await _httpClient.send(request);

    if (response.statusCode == 401) {
      final newToken = await refreshToken();

      final updatedRequest = http.Request(request.method, request.url);

      request.headers.forEach((name, value) {
        updatedRequest.headers[name] = value;
      });

      updatedRequest.headers['Authorization'] = 'Bearer $newToken';

      if (request is http.Request && request.body.isNotEmpty) {
        updatedRequest.body = request.body;
      }

      final resp = await _httpClient.send(updatedRequest);

      return resp;
    }

    return response;
  }
}
