import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:restorun/data/model/detail_result.dart';
import 'package:restorun/data/model/list_result.dart';
import 'package:restorun/data/model/search_result.dart';

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';

  static Future<ListResult> getAllData(http.Client client) async {
    dynamic responseJson;
    try {
      final response = await client.get(Uri.parse("$baseUrl/list"));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return ListResult.fromJson(responseJson);
  }

  static Future<DetailResult> getDataById(String id) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse("$baseUrl/detail/$id"));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return DetailResult.fromJson(responseJson);
  }

  static Future<SearchResult> searchData(String query) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse("$baseUrl/search?q=$query"));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return SearchResult.fromJson(responseJson);
  }

  @visibleForTesting
  static dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server with status code : ${response.statusCode}');
    }
  }
}

class AppException implements Exception {
  final dynamic message;
  final dynamic prefix;

  AppException([this.message, this.prefix]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised Request: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
