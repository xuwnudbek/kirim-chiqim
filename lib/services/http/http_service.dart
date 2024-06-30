// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class URL {
  static const String main = "tiziminfo.uz";
  static const String _additional = "api";

  //basic urls
  static String users = "$_additional/users/";
  static String debt = "$_additional/debts/";
}

class HttpService {
  //Headers
  static Map<String, String> get headers => {
        "Content-Type": "application/json",
      };

  //Functions
  static Future<Map> GET(url, {params}) async {
    Map<String, dynamic> response;
    var uri = Uri.http(URL.main, url, params);

    try {
      var res = await http.get(uri, headers: headers);

      if (res.statusCode < 299) {
        response = {
          "status": HttpResponse.data,
          "data": jsonDecode(res.body),
        };
        return response;
      } else {
        response = {
          "status": HttpResponse.error,
          "data": jsonDecode(res.body),
        };
        return response;
      }
    } catch (e) {
      print("__________________ErrorGET: $e");
      response = {
        "status": HttpResponse.none,
        "data": "connection_error".tr,
      };
    }

    return response;
  }

  static Future<Map> POST(url, {body, params}) async {
    Map<String, dynamic> response;

    var uri = Uri.http(URL.main, url, params);
    try {
      var res = await http.post(
        uri,
        body: jsonEncode(body),
        headers: headers,
      );
      if (res.statusCode < 299) {
        response = {
          "status": HttpResponse.data,
          "data": jsonDecode(res.body),
        };
      } else {
        print(res.body);
        response = {
          "status": HttpResponse.error,
          "data": jsonDecode(res.body),
        };
      }

      return response;
    } catch (e) {
      print("__________________ErrorPOST: $e");
      response = {
        "status": HttpResponse.none,
        "data": "connection_error".tr,
      };
      return response;
    }
  }
}

enum HttpResponse { error, none, data }
