import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/request.dart';

class ApiClient {
  static const String base = 'http://5.129.220.121:8000';

  Uri _u(String p, [Map<String, dynamic>? q]) => Uri.parse(
    '$base$p',
  ).replace(queryParameters: q?.map((k, v) => MapEntry(k, '$v')));

  Future<List<Request>> fetchRequests() async {
    final r = await http.get(_u('/api/requests'));
    if (r.statusCode != 200) {
      throw Exception('Fetch failed: ${r.statusCode}');
    }
    final data = jsonDecode(r.body);
    if (data is List) {
      return data
          .map((e) => Request.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<Request> createRequest({
    required String type,
    required String address,
    String? comment,
    String? duration,
    bool electrical = false,
  }) async {
    final body = jsonEncode({
      "type": type,
      "address": address,
      "comment": comment,
      "duration": duration,
      "electrical": electrical,
    });
    final r = await http.post(
      _u('/api/requests/json'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (r.statusCode != 200 && r.statusCode != 201) {
      throw Exception('Create failed: ${r.statusCode} ${r.body}');
    }
    return Request.fromJson(jsonDecode(r.body));
  }

  Future<Request> updateStatus(String id, String status) async {
    final r = await http.post(
      _u('/api/requests/$id/status'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"status": status}),
    );
    if (r.statusCode != 200) {
      throw Exception('Status update failed: ${r.statusCode} ${r.body}');
    }
    return Request.fromJson(jsonDecode(r.body));
  }
}
