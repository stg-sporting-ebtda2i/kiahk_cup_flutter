import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:piehme_cup_flutter/main.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Request {
  static const String baseUrl = 'https://piehme.stgsporting.com';

  Uri uri;
  Map<String, String> headers = {};
  bool _isMultiPart = false;
  List<http.MultipartFile> files = [];

  Request(String url) : uri = Uri.parse(baseUrl + url);

  static Future<http.Response> getFrom(String url) async {
    return await (await Request(url).contentJson().withToken()).get();
  }

  static Future<http.Response> patchTo(String url, [Map<String, dynamic>? body]) async {
    return await (await Request(url).contentJson().withToken()).patch(body);
  }

  static Future<http.Response> postTo(String url, [Map<String, dynamic>? body]) async {
    return await (await Request(url).contentJson().withToken()).post(body);
  }

  Request addHeader(String key, String value) {
    headers[key] = value;

    return this;
  }

  Request contentJson() {
    return addHeader("Content-Type", "application/json");
  }

  Future<Request> withToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwttoken');

    return addHeader("Authorization", "Bearer $token");
  }

  Request addFile(String key, File file) {
    _isMultiPart = true;
    files.add(
        http.MultipartFile.fromBytes(
            key,
            file.readAsBytesSync(),
            filename: file.path.split("/").last
        )
    );

    return this;
  }

  Future<http.Response> get() async {
    return _handle(await http.get(uri, headers: headers));
  }

  Future<http.Response> post([Map<String, dynamic>? body]) async {
    if (_isMultiPart) {
      return multipartRequest("POST", body);
    }

    return _handle(await http.post(uri, headers: headers, body: jsonEncode(body)));
  }

  Future<http.Response> patch([Map<String, dynamic>? body]) async {
    if (_isMultiPart) {
      return multipartRequest("PATCH", body);
    }

    return _handle(await http.patch(uri, headers: headers, body: jsonEncode(body)));
  }

  Future<http.Response> put([Map<String, dynamic>? body]) async {
    if (_isMultiPart) {
      return multipartRequest("PUT", body);
    }

    return _handle(await http.put(uri, headers: headers, body: jsonEncode(body)));
  }

  Future<http.Response> multipartRequest(String method, [Map<String, dynamic>? body]) async {
    final request = http.MultipartRequest(method, uri);
    request.headers.addAll(headers);

    for (http.MultipartFile file in files) {
      request.files.add(file);
    }

    if (body != null) {
      for (String key in body.keys) {
        request.fields[key] = body[key].toString();
      }
    }

    return _handle(await request.send().then((response) => http.Response.fromStream(response)));
  }

  http.Response _handle(http.Response response) {
    if (response.statusCode == 403) {
      AuthService.logout();
      navigatorKey.currentState?.pushReplacementNamed(AppRoutes.login);

      throw "You are not logged in";
    }

    if (response.statusCode != 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      throw responseBody['message'] ?? "Failed to handle request";
    }

    return response;
  }
}