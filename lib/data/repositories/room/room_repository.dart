import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../app/config/app_config.dart';
import '../../../app/constants/gasout_constants.dart';
import '../../model/room/room_response_model.dart';

class RoomRepository {
  final Dio client = Dio();

  String baseUrl = AppConfig.getInstance()!.apiBaseUrl;

  Future<List<DataRoom>> getUserRooms(String? email, int? nameId) async {

    String url = '${baseUrl}rooms/$email?roomNameId=$nameId';

    print(url);

    List<DataRoom> list = [];

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

      if (response.statusCode == 200) {
        print(response.data['data']);
      }

      response.data['data'].map((el) {
          list.add(
              DataRoom.fromJson(el)
          );
      }).toList();

      return list;

    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> updateSwitches(String email, int nameId, bool notificationOn, bool alarmOn, bool sprinklersOn) async {
    final String url = '${baseUrl}rooms';
    print(url);

    final bodyJSON = jsonEncode({
      "nameId": nameId,
      "userEmail": email,
      "notificationOn": notificationOn,
      "alarmOn": alarmOn,
      "sprinklersOn": sprinklersOn
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

      if (response.statusCode == 200) {
        print(response.data['data']);
        print("HTTP " + response.statusCode.toString());
      }
      // var jsonDataRoom = json.decode(response.data);
      // print(jsonDataRoom);
    } catch (e) {
      print(e.toString());
      throw ('Erro na conexão');
    }
  }
}
