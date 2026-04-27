import 'dart:convert';
import 'package:archiarena/core/class/status_request.dart';
import 'package:http/http.dart' as http;
import 'check_internet.dart';

class Crud {
  /// POST request
  Future<StatusRequest> post({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    required Function(Map<String, dynamic> response) onSuccess,
    bool jsonEncodeBody = true,
  }) async {
    try {

      if (!await checkInternet()) {
        return StatusRequest.offlineFailure;
      }

      final defaultHeaders = {
        'Accept': 'application/json',
      };

      if (jsonEncodeBody) {
        defaultHeaders['Content-Type'] = 'application/json';
      }

      if (headers != null) {
        defaultHeaders.addAll(headers);
      }

      final response = await http.post(
        Uri.parse(url),
        headers: defaultHeaders,
        body: jsonEncodeBody
            ? jsonEncode(body ?? {})
            : body?.map((k, v) => MapEntry(k, v.toString())),
      );

      print("STATUS CODE: ${response.statusCode}");
      print("RESPONSE BODY: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body);
        onSuccess(decoded);
        return StatusRequest.success;
      } else {
        return StatusRequest.serverFailure;
      }

    } catch (e) {
      print("ERROR: $e");
      return StatusRequest.serverFailure;
    }
  }

  /// GET request
  Future<StatusRequest> get({
    required String url,
    Map<String, String>? headers,
    required Function(Map<String, dynamic> response) onSuccess,
  }) async {
    try {
      // 1️⃣ check internet
      if (!await checkInternet()) return StatusRequest.offlineFailure;

      // 2️⃣ send request
      final response = await http.get(Uri.parse(url), headers: headers);

      // 3️⃣ handle response
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        onSuccess(decoded);
        return StatusRequest.success;
      } else {
        return StatusRequest.serverFailure;
      }
    } catch (e) {
      return StatusRequest.serverFailure;
    }
  }

  /// DELETE request
  Future<StatusRequest> delete({
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    required Function(Map<String, dynamic> response) onSuccess,
  }) async {
    try {
      if (!await checkInternet()) return StatusRequest.offlineFailure;

      final response = await http.delete(
        Uri.parse(url),
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        onSuccess(decoded);
        return StatusRequest.success;
      } else {
        return StatusRequest.serverFailure;
      }
    } catch (e) {
      return StatusRequest.serverFailure;
    }
  }

  /// PUT request
  Future<StatusRequest> put({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    required Function(Map<String, dynamic> response) onSuccess,
  }) async {
    try {
      if (!await checkInternet()) return StatusRequest.offlineFailure;

      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', ...?headers},
        body: jsonEncode(body ?? {}),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        onSuccess(decoded);
        return StatusRequest.success;
      } else {
        return StatusRequest.serverFailure;
      }
    } catch (e) {
      return StatusRequest.serverFailure;
    }
  }
}
