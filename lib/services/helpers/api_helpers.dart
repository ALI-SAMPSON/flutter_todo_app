import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todo_app/services/helpers/app_exception.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart';

class ApiHelpers {
  static Future<dynamic> getWithBody(String url, dynamic body) async {
    var responseJson;
    try {
      url = "${getApiBaseUrl()}$url";
      print('Api Get, url $url');

      var request = http.Request(
        'GET',
        Uri.parse(url),
      );
      request.body = json.encode(body);
      //request.headers.addAll(await getTokenHeader());

      http.StreamedResponse response = await request.send();

      responseJson = returnResponse(response);
    } on SocketException {
      if (kDebugMode) {
        print('No net');
      }
      throw FetchDataException('No Internet connection');
    }
    if (kDebugMode) {
      print('remote get received!');
    }
    return responseJson;
  }

  static Future<dynamic> get(String url) async {
    var responseJson;
    try {
      url = "${getApiBaseUrl()}$url";
      print('Api Get, url $url');

      var request = http.Request(
        'GET',
        Uri.parse(url),
      );
      //request.body = json.encode(body);
      //request.headers.addAll(await getTokenHeader());

      http.StreamedResponse response = await request.send();

      responseJson = returnResponse(response);
    } on SocketException {
      if (kDebugMode) {
        print('No net');
      }
      throw FetchDataException('No Internet connection');
    }
    if (kDebugMode) {
      print('remote get received!');
    }
    return responseJson;
  }

  static Future<dynamic> post(String url, dynamic body) async {
    debugPrint('Api POST, url $url');
    var responseJson;
    try {
      var request = http.Request(
        'POST',
        Uri.parse("${getApiBaseUrl()}$url"),
      );
      request.body = json.encode(body);
      //request.headers.addAll(await getTokenHeader());

      http.StreamedResponse response = await request.send();

      responseJson = returnResponse(response);
    } on SocketException {
      debugPrint('No net');
      throw FetchDataException('No Internet connection');
    }
    debugPrint('remote post!');
    return responseJson;
  }

  // return response from api
  static dynamic returnResponse(http.StreamedResponse response) async {
    if (kDebugMode) {
      debugPrint(response.statusCode.toString());
    }
    switch (response.statusCode) {
      case 200:
        // print(response.body);
        var responseJson = jsonDecode(await response.stream.bytesToString());
        print(responseJson);
        return responseJson;
      case 400:
        debugPrint('Bad Request');
        // decode response
        var responseJson = jsonDecode(await response.stream.bytesToString());
        return responseJson;
      //throw BadRequestException(responseJson['message']);

      case 401:
      case 403:
        debugPrint('UnauthorisedException');
        // decode response
        var responseJson = jsonDecode(await response.stream.bytesToString());
        return responseJson;
      //throw UnauthorisedException(responseJson['message']);
      case 500:
      default:
        // decode response
        var responseJson = jsonDecode(await response.stream.bytesToString());
        return responseJson;
        throw UnauthorisedException(responseJson['message']);
        return responseJson;
      // throw FetchDataException(
      //   'Error occurred while Communication with Server with StatusCode : ${response.statusCode}',
      // );
    }
  }

  static const bool isProduction = false;

  // return base url based on production or development env
  static String getApiBaseUrl() {
    if (isProduction) {
      return "https://jsonplaceholder.typicode.com";
    } else {
      return "https://jsonplaceholder.typicode.com";
    }
  }
}
