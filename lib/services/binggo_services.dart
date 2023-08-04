import 'dart:convert';
import 'package:binggo/constanta.dart';
import 'package:flutter/cupertino.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class BinggoServices {
  static Future<ApiReturnValue<List<BinggoModels>>> getBinggo() async {
    try {
      var url = Uri.parse(baseUrl + 'binggo_product.php');
      var response = await http.post(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET, PUT, PATCH, POST, DELETE",
          "Access-Control-Allow-Headers":
              "Origin, X-Requested-With, Content-Type, Accept",
        },
        body: {
          'whattodo': 'select_binggo',
        },
      );

      if (response.statusCode != 200) {
        throw GetBinggoException();
      }

      var data = jsonDecode(response.body)['rs'] as List;

      return ApiReturnValue(
          data: data.map((e) => BinggoModels.fromJSON(e)).toList());
    } catch (e) {
      debugPrint('Error: $e');
      throw GetBinggoException();
    }
  }

  static Future<ApiReturnValue<BinggoModels>> getBinggoDetail(
      String idBinggo) async {
    try {
      var url = Uri.parse(baseUrl + 'binggo_detail_product.php');
      var response = await http.post(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET, PUT, PATCH, POST, DELETE",
          "Access-Control-Allow-Headers":
              "Origin, X-Requested-With, Content-Type, Accept",
        },
        body: {
          'whattodo': 'select_binggo_detail',
          'P1': idBinggo,
        },
      );
      if (response.statusCode != 200) {
        throw GetDetailBinggoException();
      }

      var data = jsonDecode(response.body)['rs'] as List;

      return ApiReturnValue(data: BinggoModels.fromJSON(data.first));
    } catch (e) {
      debugPrint('Error: $e');
      throw GetDetailBinggoException();
    }
  }

  static Future<ApiReturnValue<String>> order() async {
    try {
      var url = Uri.parse(baseUrl + 'binggo_order.php');
      var response = await http.post(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET, PUT, PATCH, POST, DELETE",
          "Access-Control-Allow-Headers":
              "Origin, X-Requested-With, Content-Type, Accept",
        },
        body: {
          'whattodo': 'orderbinggo',
          'P1': 'Berhasil Order',
        },
      );
      if (response.statusCode != 200) {
        throw OrderException();
      }

      var data = jsonDecode(response.body)['rs'] as List;

      return ApiReturnValue(
        data: data.first['pesan'],
      );
    } catch (e) {
      debugPrint('Error: $e');
      throw OrderException();
    }
  }

  static Future<ApiReturnValue<String>> login(
      String username, String password) async {
    try {
      var url = Uri.parse(baseUrl + "binggo_login.php");
      // var url = Uri.https('192.168.1.17', '/binggo/binggo_login.php');
      var response = await http.post(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET, PUT, PATCH, POST, DELETE",
          "Access-Control-Allow-Headers":
              "Origin, X-Requested-With, Content-Type, Accept",
        },
        body: {
          'username': username, //'a',
          'password': password, //'a',
        },
      );

      if (response.statusCode != 200) {
        throw LoginException();
      }

      var data = jsonDecode(response.body)['islogged'] as List;

      //HANYA LOG SAJA AGAR BISA DITELUSURI HASILNYA
      log("HASIL = " + data.toString());

      if ((data.toString() != "[]") &&
          (int.parse(data.first['id_customer']) > 0)) {
        log("MASUK IF, LOGIN SUKSES");
        return ApiReturnValue(
          data: "Welcome, " + data.first['name'],
        );
      } else {
        log("MASUK ELSE, LOGIN GAGAL");
        return ApiReturnValue(data: "Login Gagal");
      }
    } catch (e) {
      debugPrint('Error: $e');
      throw LoginException();
    }
  }

  static Future<ApiReturnValue<String>> register(
      String name, String email, String username, String password) async {
    try {
      var url = Uri.parse(baseUrl + 'binggo_register.php');
      var response = await http.post(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET, PUT, PATCH, POST, DELETE",
          "Access-Control-Allow-Headers":
              "Origin, X-Requested-With, Content-Type, Accept",
        },
        body: {
          'whattodo': 'register',
          'P1': name,
          'P2': email,
          'P3': username,
          'P4': password,
          'P5': '1',
        },
      );
      if (response.statusCode != 200) {
        throw RegisterException();
      }

      var data = jsonDecode(response.body)['rs'] as List;

      return ApiReturnValue(
        data: data.first['pesan'],
      );
    } catch (e) {
      debugPrint('Error: $e');
      throw RegisterException();
    }
  }
}

class GetBinggoException implements Exception {}

class GetDetailBinggoException implements Exception {}

class OrderException implements Exception {}

class LoginException implements Exception {}

class RegisterException implements Exception {}
