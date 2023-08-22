import 'package:gas_out_app/data/repositories/room/room_repository.dart';
import 'package:mobx/mobx.dart';

import '../../../../data/model/room/room_response_model.dart';
part 'room_controller.g.dart';

class RoomController = _RoomControllerBase with _$RoomController;

abstract class _RoomControllerBase with Store {
  RoomRepository _repository = RoomRepository();

  @observable
  bool sprinklersValue = false;

  @observable
  bool alarmValue = false;

  @observable
  bool notificationValue = false;

  @action
  setSprinklersValue(bool value) {
    sprinklersValue = value;
  }

  @action
  setAlarmValue(bool value) {
    alarmValue = value;
  }

  @action
  setNotificationValue(bool value) {
    notificationValue = value;
  }

  @observable
  List<DataRoom>? roomList = [];

  @observable
  DataRoom? userRoom;

  @action
  getUserRooms(String? login, String roomName) async {
    roomList = await _repository.getUserRooms(login!, roomName);
    print(roomList);
  }

  @action
  sendRoomSensorValue(String name, String email, bool alarmOn,
      bool notificationOn, bool sprinklersOn, int sensorValue) async {
    await _repository.sendRoomSensorValue(
        name, email, alarmOn, notificationOn, sprinklersOn, sensorValue);
  }
}
