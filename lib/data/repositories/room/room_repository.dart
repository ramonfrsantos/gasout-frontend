import 'dart:convert';
import 'package:dio/dio.dart';

import '../../../app/config/app_config.dart';
import '../../../app/constants/gasout_constants.dart';
import '../../model/room/room_response_model.dart';

class RoomRepository {
  final Dio client = Dio();

  String baseUrl = AppConfig.getInstance()!.apiBaseUrl;

  Future<List<RoomResponseModel>> getUserRooms(String email) async {
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
        print(response.data);
      }

      List<RoomResponseModel> list = [];

      response.data.map((el) {
        list.add(
          RoomResponseModel.fromMap(el),
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
      // var jsonData = json.decode(response.data);
      // print(jsonData);
    } catch (e) {
      print(e.toString());
      throw ('Erro na conexão');
    }
  }
}
