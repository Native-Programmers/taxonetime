import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
APIService apiService = APIService();
// You future
late Future future;
//in the initState() or use it how you want...
class APIService {
Future future = apiService.get(endpoint:'/fixtures', query:{"live": "all"});

  // API key
  static const _api_key = '<YOU-API-KEY-HERE>';
  // Base API url
  static const String _baseUrl = "api-football-beta.p.rapidapi.com";
  // Base headers for Response url
  static const Map<String, String> _headers = {
    "content-type": "application/json",
    "x-rapidapi-host": "api-football-beta.p.rapidapi.com",
    "x-rapidapi-key": _api_key,
  };

  // Base API request to get response
  Future<dynamic> get({
    required String endpoint,
    required Map<String, String> query,
  }) async {
    Uri uri = Uri.https(_baseUrl, endpoint, query);
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return json.decode(response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load json data');
    }
  }
}