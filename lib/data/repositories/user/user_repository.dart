import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gas_out_app/app/stores/controller/login/login_controller.dart';
import 'package:gas_out_app/data/model/notiification/notification_response_model.dart';

import '../../../app/config/app_config.dart';
import '../../../app/constants/gasout_constants.dart';
import '../../model/notiification/notification_firebase_model.dart';
import '../../model/user/UserModel.dart';

class UserRepository {
  final Dio client = Dio();

  String baseUrl = AppConfig.getInstance()!.apiBaseUrl;

  Future<int?> createUser(String email, String name, String password) async {
    final String url = '${baseUrl}users';
    print(url);

    final bodyJSON =
        jsonEncode({
          "email": email,
          "name": name,
          "password": password
        });

    print(bodyJSON);

    try {
      var response = await client.post(
        url,
        data: bodyJSON,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${ConstantToken.tokenRequests}'
          },
        ),
      );

      print(response.data);

      return response.statusCode;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<String?> sendVerificationCode(String? email) async {
    final String url = '${baseUrl}users/send-verification-mail/$email';
    print(url);

    try {
      var response = await client.put(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${ConstantToken.tokenRequests}'
          },
        ),
      );

      print(response.data);

      return response.data.toString();
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  // Future<String?> getVerificationCode(String email) async {
  //   final String url = '${baseUrl}user/verification-code/$email';
  //   print(url);
  //
  //   try {
  //     var response = await client.get(
  //       url,
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'Authorization': 'Bearer ${ConstantToken.tokenRequests}'
  //         },
  //       ),
  //     );
  //
  //     print(response.data);
  //
  //     return response.data.toString();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   return null;
  // }

  Future<bool?> checkIfCodesAreEqual(String? email, String newCode) async {
    final String url = '${baseUrl}users/check-codes-equal/$newCode/$email';
    print(url);

    try {
      var response = await client.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${ConstantToken.tokenRequests}'
          },
        ),
      );

      print(response.data);

      return response.data;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<int?> refreshPassword(String? login, String password) async {
    final String url = '${baseUrl}users/refresh';
    print(url);

    final bodyJSON =
    jsonEncode({
      "login": login,
      "password": password
    });

    print(bodyJSON);

    try {
      var response = await client.put(
        url,
        data: bodyJSON,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${ConstantToken.tokenRequests}'
          },
        ),
      );

      print(response.data);

      return response.statusCode;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
