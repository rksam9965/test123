import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/configuration.dart';
import 'custom_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ApiProvider {
  Future<dynamic> postRetrieveToken(String url, String body) async {
    var responseJson;
    try {
      print(baseUrl + url + body);
      final response = await http.post(Uri.parse(baseUrl + url),
          body: body, headers: {'Content-Type': "application/json"});
      responseJson = _responseToken(response);
      print(responseJson.toString());
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _responseToken(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = (json.decode(utf8.decode(response.bodyBytes)));
        print('Response Body ' + response.body);
        String? token =
            responseJson['accessToken']; // Assuming token key in response
        print('TokenM $token');
        if (token != null) {
          saveToken(token);
        }
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body);
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());

      case 403:
        throw UnauthorisedException(response.body.toString());

      case 409:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<dynamic> post(String url, String body) async {
    print('POST URL = ' + baseUrl + url);
    print(body.toString());
    var responseJson;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      final response =
          await http.post(Uri.parse(baseUrl + url), body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    print('DELETE URL = ' + baseUrl + url);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      final response = await http.delete(
        Uri.parse(baseUrl + url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> update(String url, String body) async {
    print('UPDATE URL = ' + baseUrl + url);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      final response = await http.put(
        Uri.parse(baseUrl + url),
        body: body,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  get(String url) async {
    print('GET URL = ' + baseUrl + url);
    var responseJson;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString('token');
    // print("hheh" + token!);
    try {
      // print("Akka" + token);
      final response = await http.get(
        Uri.parse(baseUrl + url),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
          // 'Authorization': 'Bearer $token',
        },
      );
      // print('TokenMMM : ${token}');
      print(response.body);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        print(responseJson);
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body);
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 404:
        var responseJson = json.decode(response.body.toString());
        print(responseJson + "777");
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 409:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

void saveToken(String token) async {
  print('Token Mi= ' + token);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
}
