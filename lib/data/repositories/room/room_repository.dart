import 'dart:convert';
import 'package:dio/dio.dart';

import '../../../app/config/app_config.dart';
import '../../../app/constants/gasout_constants.dart';
import '../../model/room/room_response_model.dart';

class RoomRepository {
  final Dio client = Dio();

  String baseUrl = AppConfig.getInstance()!.apiBaseUrl;

  Future<List<DataRoom>> getUserRooms(String email) async {
    final String url = '${baseUrl}rooms/find-all/$email';
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

      if(response.statusCode == 200){
        print(response.data['data']);
      }

      List<DataRoom> list = [];

      response.data['data'].map((el) {
        list.add(
          DataRoom.fromJson(el),
        );
      }).toList();

      return list;
    } catch (e) {
      print(e.toString());
      throw ('Erro na conexão');
    }
  }

  Future<void> sendRoomSensorValue(String name, String email, bool alarmOn, bool notificationOn, bool sprinklersOn, int sensorValue) async {
    final String url = '${baseUrl}rooms/sensor-measurement-details/$email';
    print(url);

    final bodyJSON =
    jsonEncode({
      "alarmOn": alarmOn,
      "name" : name,
      "notificationOn": notificationOn,
      "sensorValue": sensorValue,
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

      if(response.statusCode == 200){
        print(response.data);
      }
      // var jsonDataRoom = json.decode(response.data);
      // print(jsonDataRoom);
    } catch (e) {
      print(e.toString());
      throw ('Erro na conexão');
    }
  }
}
