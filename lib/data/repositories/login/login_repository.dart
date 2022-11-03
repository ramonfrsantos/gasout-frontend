import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gas_out_app/data/model/login/login_response_model.dart';

import '../../../app/config/app_config.dart';
import '../../../app/constants/gasout_constants.dart';

class LoginRepository {
  final Dio client = Dio();
  String baseUrl = AppConfig.getInstance()!.apiBaseUrl;

  Future<LoginResponseModel?> doLogin(String login, String password) async {
    final String url = '${baseUrl}auth/login';
    print(url);

    final bodyJSON = jsonEncode({"login": login, "password": password});

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
      return LoginResponseModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
