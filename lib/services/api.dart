import 'dart:convert';

import '/models/api_result.dart';
import 'package:http/http.dart' as http;

class Api {
  static const BASE_URL = 'https://api.genshin.dev';

  Future<dynamic> fetch(
    String endPoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    String queryString = Uri(queryParameters: queryParams).query;
    var url = Uri.parse('$BASE_URL/$endPoint?$queryString');

    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // แปลง text ที่มีรูปแบบเป็น JSON ไปเป็น Dart's data structure (List/Map)
      var jsonBody;
      jsonBody = json.decode(response.body);

      print('RESPONSE BODY: $jsonBody');
      if (jsonBody is Map) {
        return ApiResult.fromJson(jsonBody).data;
      } else {
        return jsonBody;
      }
    } else {
      throw 'Server connection failed!';
    }
  }
  Future<dynamic> fetchMap(
      String endPoint, {
        Map<String, dynamic>? queryParams,
      }) async {
    String queryString = Uri(queryParameters: queryParams).query;
    var url = Uri.parse('$BASE_URL/$endPoint?$queryString');

    final response = await http.get(url,headers: {'Content-Type': 'application/json'},);

    if (response.statusCode == 200) {
      // แปลง text ที่มีรูปแบบเป็น JSON ไปเป็น Dart's data structure (List/Map)
      Map<String, dynamic> jsonBody = json.decode(response.body);

      print('RESPONSE BODY: $jsonBody');

      // แปลง Dart's data structure ไปเป็น model (POJO)
      return jsonBody;
    } else {
      throw 'Server connection failed!';
    }
  }

}
