import 'dart:convert';

import 'package:http/http.dart' as http;

class RemoteHelper {
  final http.Client client;
  final String host;
  final String basePath;

  RemoteHelper({
    required this.client,
    required this.host,
    required this.basePath,
  });

  Future<Map<String, dynamic>?> delete({required String path}) async {
    final uri = Uri.http(host, basePath + path);

    final resp = await client.delete(uri);
    if (resp.statusCode == 200) {
      return jsonDecode(resp.body);
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> get({required String path}) async {
    final uri = Uri.http(host, basePath + path);
    final resp = await client.get(uri);
    if (resp.statusCode == 200) {
      return jsonDecode(resp.body);
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> post({
    required String path,
    required Map<String, dynamic> param,
  }) async {
    final uri = Uri.http(host, basePath + path);

    final resp = await client.post(
      uri,
      body: jsonEncode(param),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );
    if (resp.statusCode == 200) {
      return jsonDecode(resp.body);
    } else {
      return null;
    }
  }
}
