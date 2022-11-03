import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gas_out_app/data/model/notiification/notification_response_model.dart';

import '../../../app/config/app_config.dart';
import '../../../app/constants/gasout_constants.dart';
import '../../model/notiification/notification_firebase_model.dart';

class NotificationRepository {
  final Dio client = Dio();

  String baseUrl = AppConfig.getInstance()!.apiBaseUrl;

  Future<List<NotificationResponseModel>> getAllNotifications() async {
    final String url = '${baseUrl}notification/find-all';
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

      if(response.statusCode == 200) {
        print(response.data);
      }

      List<NotificationResponseModel> list = [];

      response.data.map((el) {
        list.add(
          NotificationResponseModel.fromMap(el),
        );
      }).toList();

      return list;
    } catch (e) {
      print(e.toString());
      throw ('Erro na conexão');
    }
  }

  Future<List<NotificationResponseModel>> getUserNotifications(String login) async {
    final String url = '${baseUrl}notification/find-all-recent/$login';
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

      List<NotificationResponseModel> list = [];

      response.data.map((el) {
        list.add(
          NotificationResponseModel.fromMap(el),
        );
      }).toList();

      return list;
    } catch (e) {
      print(e.toString());
      throw ('Erro na conexão');
    }
  }

  Future<void> deleteNotification(String id) async {
    final String url = '${baseUrl}notification/delete/${id.toString()}';
    print(url);

    try {
      var response = await client.delete(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${ConstantToken.tokenRequests}'
          },
        ),
      );
      if(response.statusCode == 200){
        print('Notificação de id: $id excluida com sucesso.');
      }
    } catch (e) {
      print(e.toString());
      throw ('Erro na conexão');
    }
  }

  Future<void> createNotificationApp(String title, String body, String email) async {
    final String url = '${baseUrl}notification/create';
    print(url);

    final bodyJSON =
        jsonEncode({"message": body, "title": title, "email": email});

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

  Future<NotificationModel?> createNotificationFirebase(
      String title, String body, String? email, String token) async {
    print(token);

    final String url = 'https://fcm.googleapis.com/fcm/send';
    print(url);

    final bodyJSON = jsonEncode(
      {
        "registration_ids": [token],
        "notification": {"title": title, "body": body}
      },
    );

    print(bodyJSON);
    try {
      var response = await client.post(
        url,
        data: bodyJSON,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
            ConstantToken.tokenFirebase
          },
        ),
      );

      createNotificationApp(title, body, email!);

      return NotificationModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      throw ('Erro na conexão');
    }
  }
}
