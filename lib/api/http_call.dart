import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpCall {
  Future<http.Response> get(Uri url) {
    return http.get(url);
  }

  Future<http.Response> post(
    Uri url,
    Map<String, String> header,
    Map<String, dynamic> params,
  ) {
    return http.post(url, headers: header, body: params);
  }
}
